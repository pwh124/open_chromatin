
library(tidyverse)

#Reading-in the hi-c interactions from each cell type
song.excite <- read_tsv("song_excitatory_hic.tsv") %>%
  # Renaming columns
  dplyr::rename("lhs.fragment"=`lhs.chr,lhs.start,lhs.end`,
                "rhs.fragment"=`rhs.chr,rhs.start,rhs.end`,
                "reads"=`#.reads`,
                "neg.log10p"=`-log10.p-value`) %>%
  dplyr::select(-specificity) %>% # remove these if you want to see the problem
  dplyr::mutate(cell="excitatory")
song.excite[is.na(song.excite)] <- "" #Change NAs to nothing

song.hippo <- read_tsv("song_hippocampus_hic.tsv") %>%
  dplyr::rename("lhs.fragment"=`lhs.chr,lhs.start,lhs.end`,
                "rhs.fragment"=`rhs.chr,rhs.start,rhs.end`,
                "reads"=`#.reads`,
                "neg.log10p"=`-log10.p-value`) %>%
  dplyr::select(-specificity) %>%
  dplyr::mutate(cell="hippocampal")
song.hippo[is.na(song.hippo)] <- ""

song.astro <- read_tsv("song_astro_hic.tsv") %>%
  dplyr::rename("lhs.fragment"=`lhs.chr,lhs.start,lhs.end`,
                "rhs.fragment"=`rhs.chr,rhs.start,rhs.end`,
                "reads"=`#.reads`,
                "neg.log10p"=`-log10.p-value`) %>%
  dplyr::select(-specificity) %>%
  dplyr::mutate(cell="astrocyte")
song.astro[is.na(song.astro)] <- ""

song.motor <- read_tsv("song_motor_hic.tsv") %>%
  dplyr::rename("lhs.fragment"=`lhs.chr,lhs.start,lhs.end`,
                "rhs.fragment"=`rhs.chr,rhs.start,rhs.end`,
                "reads"=`#.reads`,
                "neg.log10p"=`-log10.p-value`) %>%
  dplyr::select(-specificity) %>%
  dplyr::mutate(cell="motor")
song.motor[is.na(song.motor)] <- ""

# Combining all the interaction data
song.interactions <- rbind(song.excite,song.astro,song.hippo,song.motor)

# Counting number of interactions
nrow(song.interactions) # 33111

# Collapsing columns and remaking a "specificity" column
tmp <- song.interactions %>%
  dplyr::select(-reads,-neg.log10p)

unique.song.interactions <- tmp %>%
  dplyr::group_by(.dots=names(tmp)[-grep("cell", names(tmp))]) %>%
  dplyr::summarise(specificity = paste(cell, collapse=", ")) %>%
  dplyr::ungroup()
# 195322 - this matches the number reported in the paper showing that I didn't lose any data while doing this

#Time to count the number of interations that fall in the 3 general categories of interactions: promoter-other,promoter-promoter,other-other
# Promoter-other
## All the unique interactions where the rhs is the 'other'
rhs <- unique.song.interactions %>%
  dplyr::filter(promoter.rhs == 0 & promoter.other.rhs == 0) %>%
  dplyr::filter(promoter.lhs > 0 | promoter.other.lhs > 0)
## All the unique interactions where the lhs is the 'other'
lhs <- unique.song.interactions %>%
  dplyr::filter(promoter.rhs > 0 | promoter.other.rhs > 0) %>%
  dplyr::filter(promoter.lhs == 0 & promoter.other.lhs == 0)

nrow(rhs) + nrow(lhs) # 92305

## All the unique promoter-promoter interactions
prom.prom <- unique.song.interactions %>%
  dplyr::filter(promoter.lhs > 0 | promoter.other.lhs > 0) %>%
  dplyr::filter(promoter.rhs > 0 | promoter.other.rhs > 0)
nrow(prom.prom) # 62435

# All the unique other-other interactions
other.other <- unique.song.interactions %>%
  dplyr::filter(promoter.lhs == 0 & promoter.other.lhs == 0) %>%
  dplyr::filter(promoter.rhs == 0 & promoter.other.rhs == 0)
nrow(other.other) # 40582

# I think all these numbers match the paper. They do not report 'other-other' interactions even though they definitely exist in the data. They report ~60% promoter-other interactions and that number makes sense if you exclude the other-other (92305/(92305+62435) = 0.596). I am going to include just interactions involving promoters because we want to link SNPs to promoters

#Making BED files for each cell population that can be used in the WASHU genome browser
washu <- unique.song.interactions %>%
  dplyr::select(lhs.fragment,rhs.fragment,specificity) %>%
  tidyr::separate(lhs.fragment,into=c("chr","start","end"),sep=",") %>%
  dplyr::mutate(score=5) %>%
  dplyr::mutate(rhs=paste0(rhs.fragment,",",score)) %>%
  dplyr::select(chr,start,end,rhs,specificity)

washu.excitatory <- washu %>%
  dplyr::filter(str_detect(specificity,"excitatory")) %>%
  dplyr::select(-specificity)
write_tsv(washu.excitatory,"WASHU_excitatory-song.txt",col_names = FALSE)

washu.hippo <- washu %>%
  dplyr::filter(str_detect(specificity,"hippocampal")) %>%
  dplyr::select(-specificity)
write_tsv(washu.hippo,"WASHU_hippocampal-song.txt",col_names = FALSE)

washu.motor <- washu %>%
  dplyr::filter(str_detect(specificity,"motor")) %>%
  dplyr::select(-specificity)
write_tsv(washu.motor,"WASHU_motor-song.txt",col_names = FALSE)

washu.astro <- washu %>%
  dplyr::filter(str_detect(specificity,"astrocyte")) %>%
  dplyr::select(-specificity)
write_tsv(washu.astro,"WASHU_astrocyte-song.txt",col_names = FALSE)

# Process promoter-other interactions into a BED-like format
# DF for promoters in the lhs. Viewpoint is the 'other' fragment
rhs.distal <- unique.song.interactions %>%
  dplyr::filter(promoter.rhs == 0 & promoter.other.rhs == 0) %>%
  dplyr::filter(promoter.lhs > 0 | promoter.other.lhs > 0) %>%
  dplyr::rename("prom.frag"=lhs.fragment,"viewpoint"=rhs.fragment) %>%
  dplyr::select(viewpoint,prom.frag,specificity,promoter.lhs.ids,promoter.other.lhs.ids) %>%
  dplyr::mutate(promoter=str_c(promoter.lhs.ids,promoter.other.lhs.ids,sep = ",")) %>%
  dplyr::select(-promoter.lhs.ids,-promoter.other.lhs.ids) %>%
  dplyr::mutate(viewpoint_side="rhs")

# DF for promoters in the rhs. Viewpoint is the 'other' fragment
lhs.distal <- unique.song.interactions %>%
  dplyr::filter(promoter.rhs > 0 | promoter.other.rhs > 0) %>%
  dplyr::filter(promoter.lhs == 0 & promoter.other.lhs == 0) %>%
  dplyr::rename("prom.frag"=rhs.fragment,"viewpoint"=lhs.fragment) %>%
  dplyr::select(viewpoint,prom.frag,specificity,promoter.rhs.ids,promoter.other.rhs.ids) %>%
  dplyr::mutate(promoter=str_c(promoter.rhs.ids,promoter.other.rhs.ids,sep = ",")) %>%
  dplyr::select(-promoter.rhs.ids,-promoter.other.rhs.ids) %>%
  dplyr::mutate(viewpoint_side="lhs")

# Combine both and label with 'pe' for promoter-other
all.distal <- rbind(lhs.distal,rhs.distal) %>%
  dplyr::mutate(interact.id=paste0("po_",row_number())) %>%
  # Process the promoter list to make it nice
  dplyr::mutate(promoter=str_remove(promoter,",$")) %>%
  dplyr::mutate(promoter=str_remove(promoter,"^,")) %>%
  # Marking that there is not a promoter in the viewpoint
  dplyr::mutate(viewpoint.prom=".")

nrow(all.distal) # 92305 - so even after all the processing, we still have the same number of interactions

#Process promoter-promoter interactions. This is a bit trickier because we want to be able to look at the PP interactions from both sides (lhs and rhs). So we need to split the interactions into two.
# Viewpoint is from the rhs
rhs.prom <- unique.song.interactions %>%
  # Selecting PP interactions and renaming things
  dplyr::filter(promoter.rhs > 0 | promoter.other.rhs > 0) %>%
  dplyr::filter(promoter.lhs > 0 | promoter.other.lhs > 0) %>%
  dplyr::rename("viewpoint"=rhs.fragment,
                "prom.frag"=lhs.fragment) %>%
  # Selecting columns
  dplyr::select(viewpoint,prom.frag,specificity,ends_with("ids")) %>%
  # Creating promoter fragment promoter lists and making this look nice
  dplyr::mutate(promoter=str_c(promoter.lhs.ids,promoter.other.lhs.ids,sep = ",")) %>%
  dplyr::mutate(promoter=str_remove(promoter,",$")) %>%
  dplyr::mutate(promoter=str_remove(promoter,"^,")) %>%
  # Labeling the interactions with 'pp'
  dplyr::mutate(interact.id=paste0("pp_",row_number())) %>%
  # Marking where the viewpoint side came from
  dplyr::mutate(viewpoint_side="rhs") %>%
  # Processing viewpoint fragment promoter list
  dplyr::mutate(viewpoint.prom=str_c(promoter.rhs.ids,promoter.other.rhs.ids,sep = ",")) %>%
  dplyr::mutate(viewpoint.prom=str_remove(viewpoint.prom,",$")) %>%
  dplyr::mutate(viewpoint.prom=str_remove(viewpoint.prom,"^,")) %>%
  # Removing all the lhs/rhs columns
  dplyr::select(-ends_with("ids"))

# Viewpoint is from the lhs
lhs.prom <- unique.song.interactions %>%
  dplyr::filter(promoter.rhs > 0 | promoter.other.rhs > 0) %>%
  dplyr::filter(promoter.lhs > 0 | promoter.other.lhs > 0) %>%
  dplyr::rename("viewpoint"=lhs.fragment,
                "prom.frag"=rhs.fragment) %>%
  dplyr::select(viewpoint,prom.frag,specificity,ends_with("ids")) %>%
  dplyr::mutate(promoter=str_c(promoter.rhs.ids,promoter.other.rhs.ids,sep = ",")) %>%
  dplyr::mutate(promoter=str_remove(promoter,",$")) %>%
  dplyr::mutate(promoter=str_remove(promoter,"^,")) %>%
  dplyr::mutate(interact.id=paste0("pp_",row_number())) %>%
  dplyr::mutate(viewpoint_side="lhs") %>%
  dplyr::mutate(viewpoint.prom=str_c(promoter.lhs.ids,promoter.other.lhs.ids,sep = ",")) %>%
  dplyr::mutate(viewpoint.prom=str_remove(viewpoint.prom,",$")) %>%
  dplyr::mutate(viewpoint.prom=str_remove(viewpoint.prom,"^,")) %>%
  dplyr::select(-ends_with("ids"))

all.prom <- rbind(lhs.prom,rhs.prom)
nrow(all.prom) # remember this should be doubled from the number above 62435*2=124870. It does

#Now I need to combine all the interactions
# Combining all the interactions
all.interactions <- rbind(all.distal,all.prom) %>%
  # Spliting the 'viewpoint' coordinates into a BED-like format
  tidyr::separate(viewpoint,into=c("chr","start","end"),sep=",")

# Counting
nrow(all.interactions) # 217175 interactions
nrow(unique(all.interactions[,1:4])) # all of them unique

# Number of interactions matching the total number of pp and pe interactions. Remember pp interactions are doubled so both sides of the interaction can be assayed. This will help us link SNPs to promoters but the labels for each interaction should sum to the po and pp interactions. It does.
length(unique(all.interactions$interact.id))

# Write out
write_tsv(all.interactions,"song_all.interactions.bed",col_names = FALSE)