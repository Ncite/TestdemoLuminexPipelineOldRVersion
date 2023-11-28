
if(tolower(investigation) == "nexgen"){
  # NEXGEN --------------------------------------------
  
  metadata <- list(design = NULL,
                   data_files = NULL,
                   reruns = NULL,
                   tech = NULL,
                   timepoints = NULL,
                   kits = NULL)
  print(str(metadata))
  
  print(directory_data)
  #tmp <- list.dirs(directory_data, full.names = FALSE) #previous code.
  tmp <- list.dirs(directory_data, 
                   recursive=F, 
                   full.names = FALSE)[which(lengths(lapply(list.dirs(directory_data, 
                                                                      recursive=F), 
                                                            list.dirs)) > 0)] #Updated code 20November2023.
  if("" %in% tmp){
    tmp <- tmp[tmp != ""]
  }
  
  tmp1 <- paste(directory_data, tmp, sep = "/")
  
  tmp1 <- lapply(tmp1, function(x) length(list.files(x, full.names = FALSE)))
  tmp1 <- unlist(tmp1)
  
  if(length(tmp) == 0){
    #  tmp <- c(".")
    metadata$data_files <- tibble(kits = list.files(directory_data)) %>%
      mutate(
        kits = gsub("^(.*)_[BM]P_.*","\\1", kits),
        kits = ifelse(
          grepl("^HCYTOMAG60$", kits),
          "HCYTOMAG60K",
          kits
        )
      ) %>%
      group_by(kits) %>%
      summarise(nr_of_plates = n()) %>%
      ungroup() %>%
      mutate(analytes_per_kit = c(2, 8, 6, 1, 1, 18, 3, 4, 3))
  } else {
    metadata$data_files <- tibble(kits = tmp,
                                  nr_of_plates = tmp1,
                                  analytes_per_kit = c(2, 8, 6, 1, 1, 18, 3, 4, 3))
  }
  
  print(str(metadata))
  
  metadata$tech <- list(parts = 4, instrument_names = c("BP", "MP"))
  
  metadata$design <- tibble(tot_specimens = 440,
                            tot_subjects = 278)
  
  # Make data frame to list description with their time points and stimulation condition.
  # colnames = description, timepoint, stimulation
  
  # NEXGEN DATA SPECIFIC
  timepoints <- tibble(description = c("432016_181",  "432055_182",  "432077_180",  "432082_178",  "432086_166",
                                       "432090_179",  "432215_179" , "432262_180",  "432265_173", "432279_175",
                                       "432902_175",  "432927_172",  "434637_172",  "435725_172",  "435769_173",
                                       "435905_180",  "435912_179",  "435917_173",  "435918_182",  "435933_178",
                                       "435966_166",  "435970_181",  "A258",        "A295",        "A297",
                                       "A311",        "A316",        "A317",        "A320",        "A321",
                                       "A323",        "A331",        "A333",        "A335",        "A336",
                                       "A339",        "A356",        "A376",        "CS",          "CU",
                                       "NG002_14",    "NG002_2",     "NG004_14",    "NG004_2",     "NG005_14",
                                       "NG005_2",     "NG006_14",    "NG006_2",     "NG007_14",    "NG007_2",
                                       "NG008_2",     "NG009_14",    "NG009_2",     "NG010_14",    "NG010_2",
                                       "NG010_28",    "NG012_2",   "NG013_14",    "NG013_2",     "NG014_14",
                                       "NG014_2",     "NG015_14",    "NG015_2",     "NG017_14",    "NG017_2",
                                       "NG019_2",     "NG019_28",    "NG021_2",     "NG023_2",     "NG024_2",
                                       "NG025_2",     "NG026_2",    "NG027_14",    "NG027_2",     "NG029_14",
                                       "NG029_2",     "NG030_14",    "NG030_2",     "NG032_14",    "NG032_2",
                                       "NG033_2",     "NG036_14",    "NG036_2",    "NG037_14",    "NG037_2" ,
                                       "NG039_14",    "NG039_2",     "NG040_14",    "NG040_2",     "NG041_14",
                                       "NG041_2",     "NG042_2",     "NG043_2",     "NG044_2",     "NG045_2",
                                       "NG046_2",     "NG047_2",     "NG047_28",    "NG050_14",    "NG050_2" ,
                                       "NG051_14",    "NG051_2",     "NG054_14",    "NG054_2",     "NG055_14",
                                       "NG055_2",     "NG058_2",     "NG060_14",    "NG060_2",     "NG061_14",
                                       "NG061_2",     "NG062_14",    "NG062_2",     "NG063_14",    "NG063_2",
                                       "NG063_28",    "NG064_14",    "NG064_2",     "NG066_14",    "NG066_2",
                                       "NG067_14",    "NG067_2",     "NG068_14",    "NG068_2" ,    "NG069_14",
                                       "NG069_2",     "NG069_28",    "NG070_14",    "NG070_2",     "NG071_14",
                                       "NG071_2",     "NG072_2",     "NG075_14",    "NG075_2",     "NG076_14",
                                       "NG076_2",     "NG077_14",    "NG077_2",     "NG078_14",    "NG078_2",
                                       "NG081_14",    "NG081_2",     "NG082_14",    "NG082_2",     "NG083_14",
                                       "NG083_2",     "NG085_14",    "NG085_2",     "NG087_14",    "NG087_2",
                                       "NG088_2",     "NG090_2",     "NG092_14",    "NG092_2",     "NG092_28",
                                       "NG093_14",    "NG093_2",     "NG094_2",     "NG099_14",    "NG099_2",
                                       "NG100_2",     "NG101_14",    "NG101_2",     "NG102_14",    "NG102_2",
                                       "NG105_14",    "NG105_2" ,    "NG106_14",    "NG106_2",     "NG109_14",
                                       "NG109_2",     "NG109_28",    "NG110_14",    "NG110_2",     "NG111_14",
                                       "NG111_2",     "NG112_14",    "NG112_2",     "NG114_2",     "NG115_14",
                                       "NG115_2",     "NG116_14",    "NG116_2",     "NG118_14",    "NG118_2",
                                       "NG119_2",     "NG120_14",    "NG120_2",     "NG120_28",    "NG121_2",
                                       "NG122_2",     "NG124_14",    "NG124_2",     "NG124_28",    "NG125_14",
                                       "NG125_2",     "NG126_14",    "NG126_2",     "NG127_14",    "NG127_2",
                                       "NG128_14",    "NG128_2",     "NG131_14",    "NG131_2" ,    "NG132_14",
                                       "NG132_2",     "NG135_14",    "NG135_2",     "NG136_14",    "NG136_2",
                                       "NG137_2",     "NG138_2",     "NG142_14",    "NG142_2",     "NG143_2",
                                       "NG145_2",     "NG145_28",    "NG146_14",    "NG146_2",     "NG148_14",
                                       "NG148_2",     "NG149_2",     "NG150_2",     "NG151_14",    "NG151_2",
                                       "NG152_14",    "NG152_2",     "NG153_14",    "NG153_2" ,    "NG154_2",
                                       "NG155_2",     "NG157_14",    "NG157_2",     "NG158_14",    "NG158_2",
                                       "NG158_28",    "NG160_14",    "NG160_2",     "NG161_14",    "NG161_2",
                                       "NG162_14",    "NG162_2",     "NG163_2",     "NG164_14",    "NG164_2",
                                       "NG166_14",    "NG166_2",     "NG167_2",     "NG167_28",    "NG168_14",
                                       "NG168_2",     "NG170_2",     "NG173_14",    "NG173_2",    "NG174_14",
                                       "NG174_2",     "NG175_14",    "NG175_2",     "NG176_2",     "NG179_14",
                                       "NG179_2",     "NG180_14",    "NG180_2",     "NG181_14",    "NG181_2",
                                       "NG182_14",    "NG182_2",     "NG183_14",    "NG183_2",     "NG185_14",
                                       "NG185_2" ,    "NG185_28",    "NG186_2",     "NG188_14",    "NG188_2",
                                       "NG189_14",    "NG189_2",     "NG191_14",    "NG191_2",     "NG192_2",
                                       "NG193_14",    "NG193_2",     "NG197_14",   "NG197_2",     "NG199_14",
                                       "NG199_2",     "NG200_2",     "NG202_14",    "NG202_2",     "NG204_14",
                                       "NG204_2",     "NG206_14",    "NG206_2",     "NG206_28",    "NG207_14",
                                       "NG207_2",     "NG209_2",     "NG211_14",    "NG211_2",     "NG213_14",
                                       "NG213_2",     "NG214_2",     "NG215_2",     "NG217_14",    "NG217_2",
                                       "NG218_14",    "NG218_2",     "NG218_28",    "NG219_2",     "NG220_14",
                                       "NG220_2",     "NG222_2",     "NG223_2",     "NG223_28",    "NG224_2",
                                       "NG225_14",    "NG225_2",     "NG227_14",    "NG227_2",     "NG228_14",
                                       "NG228_2",     "NG230_14",    "NG230_2",     "NG231_14",    "NG231_2",
                                       "NG232_14",    "NG232_2",     "NG233_2",     "NG234_2",     "NG236_14",
                                       "NG236_2",     "NG238_14",    "NG238_2",     "NG238_28",    "NG239_14",
                                       "NG239_2",     "NG241_14",    "NG241_2",     "NG242_14",    "NG242_2",
                                       "NG243_14",    "NG243_2",     "NG244_14",    "NG244_2",     "NG245_14",
                                       "NG245_2",     "NG246_14",    "NG246_2",     "NG247_14",    "NG247_2",
                                       "NG248_14",    "NG248_2",     "NG248_28",    "NG250_14",    "NG250_2",
                                       "NG251_2",     "NG252_14",    "NG252_2",     "NG252_28",    "NG253_14",
                                       "NG253_2",     "NG254_14",    "NG254_2",     "NG257_14",    "NG257_2",
                                       "NG258_14",    "NG258_2",     "NG259_14",    "NG259_2",    "NG261_14",
                                       "NG261_2",     "NG262_14",    "NG262_2",     "PS",          "PU",
                                       "SCRN0081_BL", "SCRN0395_BL", "SCRN0395_M2", "SCRN0424_BL", "SCRN0426_BL",
                                       "SCRN0426_M2", "SCRN0428_BL", "SCRN0428_M2", "SCRN0592_D0", "SCRN0593_D0",
                                       "SCRN0593_M2", "SCRN0594_D0", "SCRN0594_M2", "SCRN0622_D0", "SCRN0622_M2",
                                       "SCRN0624_D0", "SCRN0626_DO", "SCRN0626_M2", "SCRN0627_D0", "SCRN0628_D0",
                                       "SCRN0659_D0", "SCRN0693_D0", "SU008742",    "SU008874",  "SU009158",
                                       "SU009192",    "SU009382",    "SU009417",    "SU009994",    "SU010042",
                                       "SU010296",    "SU012384",    "SU013158",    "SU013248",    "SU013275",
                                       "SU013364",    "SU013706",    "SU015244",    "SU015647",    "SU016083",
                                       "SU016251",    "SU016521",    "SU016808",    "TDMD048",     "TDMD051",
                                       "TDMT016_BL",  "TDMT037_BL",  "TDMT037_M2",  "TDMT047_HC",  "TDMT057_HC",
                                       "TDMT119_BL",  "TDMT119_M2",  "TDMT136_BL",  "TDMT137_BL",  "TDMT142_BL",
                                       "TDMT142_M2",  "TDMT143_BL",  "TDMT143_M2",  "TDMT144_BL",  "TDMT146_BL",
                                       "TDMT147_BL",  "TDMT148_BL",  "TDMT160_BL",  "TDMT161_BL",  "TDMT167_BL"))
  
  timepoints <- timepoints %>%
    mutate(timepoint = case_when(str_detect(description, "_2$") ~ "day2",
                                 str_detect(description, "_28$") ~ "day28",
                                 str_detect(description, "_14$") ~ "day14",
                                 str_detect(description, "_BL$") ~ "bl",
                                 str_detect(description, "_D0$") ~ "day0",
                                 str_detect(description, "_M2$") ~ "month2",
                                 TRUE ~ "bl"),
           stimulation = "unstim",
           study_group = "grp_1",
           tech_reps_nr = 1)
  
  metadata$timepoints <- timepoints
  
  # Provide the kitnames of the experiment.
  # THIS IS NEXGEN SPECIFIC.
  
  kits_expected <- c("APOMAG62K", "HCMP1MAG19K",  "HCMP2MAG19K",
                     "HCVD2MAG67K",  "HCYP3MAG63K",
                     "HCYTOMAG60K",  "HNDG2MAG36K",
                     "HSCRMAG32K",   "RnD3plex_L125308")
  
  kits_expected_w_mistake <- c("APOMAG62K", "HCMP1MAG19K",  "HCMP2MAG19K",
                               "HCVD2MAG67K",  "HCYP3MAG63K",
                               "HCYTOMAG60",
                               "HCYTOMAG60K",  "HNDG2MAG36K",
                               "HSCRMAG32K",   "RnD3plex_L125308")
  
  metadata$kits <- list(kits_expected = kits_expected,
                        kits_expected_w_mistake = kits_expected_w_mistake)
  
  
  write_rds(metadata, "./rds/metadata.rds")
  
  
  
} else if(tolower(investigation) == "r01ai128765"){
  
  # R01AI128765 -----------------------------------------------------------------
  
  metadata <- list(design = NULL,
                   data_files = NULL,
                   reruns = NULL,
                   tech = NULL,
                   timepoints = NULL,
                   kits = NULL)
  print(str(metadata))
  #tmp <- list.dirs(directory_data, full.names = FALSE) #previous code.
  tmp <- list.dirs(directory_data, 
                   recursive=F, 
                   full.names = FALSE)[which(lengths(lapply(list.dirs(directory_data, 
                                                                      recursive=F), 
                                                            list.dirs)) > 0)] #Updated code 20November2023.
  if("" %in% tmp){
    tmp <- tmp[tmp != ""]
  }
  
  tmp1 <- paste(directory_data, tmp, sep = "/")
  
  tmp1 <- lapply(tmp1, function(x) length(list.files(x, full.names = FALSE)))
  tmp1 <- unlist(tmp1)
  
  metadata$data_files <- tibble(kits = tmp,
                                nr_of_plates = tmp1,
                                analytes_per_kit = c(2, 1, 5, 2, 22, 4, 5))
  print(str(metadata))
  
  metadata$tech <- list(parts = 4, instrument_names = c("BP", "MP"))
  
  metadata$design <- tibble(tot_specimens = 578,
                            tot_subjects = 578)
  
  # Make data frame to list description with their time points and stimulation condition.
  # colnames = description, timepoint, stimulation
  
  # R01AI128765 DATA SPECIFIC
  timepoints <- tibble(description = c("12359" ,               "40632"               , "12337"               , "KLF-500077 /500077"
                                       ,"PG0564" ,              "12939"              ,  "KLF-94018"         ,   "40219"
                                       ,"KLF-500009 /500009",   "KLF-500109"           ,"KLF-96951 /100430"  ,  "12497"
                                       ,"KLF-96576 /100410"  ,  "KLF-m-500544 /500544" ,"KLF-500342 /500342"  , "10050"
                                       ,"12226"               , "12807"                ,"12455"                ,"40583"
                                       ,"10021"                ,"KLF-3-104652 /800958" ,"40441"                ,"12282"
                                       ,"KLF-93994"            ,"40179"                ,"12214"                ,"40594"
                                       ,"40204"                ,"12190"                ,"10433"                ,"KLF-96571"
                                       ,"40611"                ,"KLF-3-101323 /800760" ,"10260"                ,"10143"
                                       ,"PG1614"               ,"40295"                ,"KLF-97946"            ,"10423"
                                       ,"KLF-100115"           ,"12306"                ,"KLF-500236 /500236"   ,"KLF-m-500369 /500369"
                                       ,"PG0960"               ,"PG0286"               ,"PG1151"               ,"10080"
                                       ,"PG0504"               ,"10733"                ,"12517"                ,"40206"
                                       ,"PG0482"               ,"10182"                ,"12298"                ,"10321"
                                       ,"10126"                ,"12408"                ,"PG0441"               ,"12600"
                                       ,"PG0459"               ,"PG0478"               ,"40101"                ,"12171"
                                       ,"KLF-97519 /100489"    ,"40105"                ,"10742"                ,"12199"
                                       ,"40476"                ,"12494"                ,"PG0817"               ,"KLF-98645 /100569"
                                       ,"40160"                ,"40457"                ,"40701"                ,"PG0399"
                                       ,"10266"                ,"KLF-94605"            ,"40660"                ,"40456"
                                       ,"10479"                ,"PG1306"               ,"40347"                ,"PG0736"
                                       ,  "12383"               , "40264"               , "PG0384"             ,  "40335"
                                       ,  "10263"               , "KLF-98474 /100556"   , "40114"              ,  "10329"
                                       , "PG1157"               ,"10214"                ,"KLF-m-500570"        , "KLF-94088"
                                       ,  "40540"               , "KLF-94295"           , "10176"              ,  "12486"
                                       ,  "12575"               , "12326"               , "KLF-96816 /100438"  ,  "10227"
                                       ,  "KLF-100200"          , "KLF-94037"           , "12230"              ,  "40380"
                                       ,  "40097"               , "40444"                ,"12775"              ,  "40362"
                                       ,  "12385"               , "40187"                ,"KLF-500179"         ,  "12147"
                                       ,  "10630"               , "PG1598"               ,"12508"              ,  "10312"
                                       ,  "G18-036"             , "KLF-92420"            ,"PG0617"             ,  "40080"
                                       ,  "12485"               , "10336"                ,"10422"              ,  "12312"
                                       ,  "12554"               , "12899"                ,"KLF-500089 /500089" ,  "12329"
                                       ,  "KLF-99174 /100594"   , "10355"                ,"40068"              ,  "40318"
                                       ,  "10237"               , "10261"                ,"40510"              ,  "40082"
                                       ,  "KLF-94510"           , "40397"                ,"PG0933"             ,  "KLF-99688 /800669"
                                       , "40511"                ,"KLF-100443 /100443"   ,"10700"               , "40378"
                                       ,  "10496"               , "10438"                ,"40401"              ,  "KLF-95629"
                                       ,  "10716"               , "40138"                ,"10483"              ,  "12513"
                                       ,  "10401"               , "PG0471"               ,"40007"              ,  "40214"
                                       ,  "10265"               , "40188"                ,"12314"              ,  "10386"
                                       ,  "10225"               , "KLF-97168 /100458"    ,"40345"              ,  "12751"
                                       ,  "12292"               , "KLF-94280"            ,"KLF-100711 /800733" ,  "KLF-99917 /100651"
                                       ,  "10058"               , "40573"                ,"PG0623"             ,  "10115"
                                       ,  "12470"               , "40034"                ,"KLF-93501"          ,  "10285"
                                       ,  "40541"               , "KLF-500288"           ,"12495"              ,  "KLF-96769"
                                       ,  "PG0768"              , "10674"                ,"KLF-m-500562 /500562", "12782"
                                       ,  "10291"               , "10244"                ,"10144"                ,"40198"
                                       ,  "KLF-93986"           , "PG0697"               ,"10162"                ,"40685"
                                       ,  "PG0398"              , "PG0658"               ,"KLF-94747"            ,"KLF-96638"
                                       ,  "10114"               , "KLF-97099 /100448"    ,"10307"                ,"KLF-100166"
                                       ,  "KLF-3-104493 /800971", "40137"                ,"KLF-500053 /500053"   ,"12436"
                                       ,  "12183"               , "PG0749"               ,"KLF-100243"           ,"40325"
                                       ,  "40398"               , "40182"                ,"12503"                ,"12616"
                                       ,  "10245"               , "40400"                ,"KLF-97533 /100487"    ,"10189"
                                       ,  "40121"               , "12332"                ,"12266"                ,"40477"
                                       ,  "10233"               , "KLF-100421"           ,"10206"                ,"12237"
                                       ,  "KLF-94902"           , "12435"                ,"10377"                ,"40263"
                                       ,  "KLF-500190"          , "40200"                ,"12251"                ,"12164"
                                       ,  "12903"               , "12833"                ,"PG0502"               ,"40289"
                                       ,  "40156"               , "10280"                ,"KLF-96379"            ,"12998"
                                       ,  "12809"               , "10146"                ,"40166"                ,"PG0570"
                                       ,  "10219"               , "12951"                ,"40181"                ,"10090"
                                       ,  "10223"               , "12373"                ,"12320"                ,"KLF-96721 /100413"
                                       ,  "40417"               , "12384"                ,"10241"                ,"10404"
                                       ,  "KLF-100352"          , "12447"                ,"40189"                ,"40248"
                                       ,  "KLF-500113 /500113"  , "12719"                ,"40348"                ,"KLF-93937"
                                       ,  "40502"               , "12492"                ,"KLF-500130 /500130"   ,"KLF-97204 /100460"
                                       ,  "KLF-94591"           , "12489"                ,"10366"                ,"PG0594"
                                       ,  "PG0592"              , "10274"                ,"10374"                ,"KLF-97406 /100472"
                                       ,  "10434"               , "12520"                ,"KLF-500086"           ,"12355"
                                       ,  "PG0885"              , "12537"                ,"12910"                ,"PG1535"
                                       ,  "KLF-m-500656 /500656", "40472"                ,"40443"                ,"10229"
                                       ,  "12514"               , "10102"                ,"PG0397"               ,"40385"
                                       ,  "12454"               , "10040"                ,"12523"                ,"KLF-93916"
                                       ,  "12479"               , "40539"                ,"PG0389"               ,"10098"
                                       ,  "KLF-97450 /100484"   , "40523"                ,"PG0820"               ,"12398"
                                       ,  "40193"               , "10493"                ,"10240"                ,"12434"
                                       ,  "12529"               , "40327"                ,"12623"                ,"10153"
                                       ,  "10612"               , "KLF-98481 /100516"    ,"40399"                ,"KLF-99056 /100598"
                                       ,  "10284"               , "PG1339"               ,"12528"                ,"10320"
                                       , "10190"                ,"KLF-3-101670 /800772" ,"12216"                ,"12516"
                                       ,  "10025"               , "10644"               , "40050"                ,"KLF-100090 /800682"
                                       ,  "KLF-93791"           , "12381"                ,"KLF-98686 /100567"    ,"KLF-97461 /100485"
                                       ,  "10148"               , "12835"                ,"40451"                ,"10302"
                                       ,  "10088"               , "KLF-96132"            ,"KLF-96051"            ,"PG0448"
                                       ,  "KLF-93691"           , "KLF-99960 /100655"    ,"KLF-92761"            ,"40095"
                                       ,  "10124"               , "12546"                ,"40320"                ,"10578"
                                       ,  "12824"               , "PG0560"               ,"12297"                ,"12186"
                                       ,  "12358"               , "KLF-500279"           ,"12642"                ,"12193"
                                       ,  "PG0812"              , "KLF-500029"           ,"12430"                ,"40332"
                                       ,  "10719"               , "12496"                ,"10344"                ,"10123"
                                       ,  "KLF-100100"          , "PG0377"               ,"10150"                ,"12278"
                                       ,  "KLF-500191"          , "KLF-100310"           ,"10002"                ,"40369"
                                       ,  "KLF-500088"          , "10172"                ,"10129"                ,"PG0528"
                                       ,  "KLF-3-101467 /800768", "PG1421"               ,"10024"                ,"PG0493"
                                       ,  "12453"               , "PG0505"               ,"KLF-94751"            ,"PG0433"
                                       ,  "12437"               , "12498"                ,"40171"                ,"KLF-96454"
                                       ,  "40377"               , "KLF-99459 /100623"    ,"40442"                ,"KLF-96089"
                                       ,  "10654"               , "KLF-500056 /500056"   ,"40211"                ,"KLF-100431 /100431"
                                       ,  "12340"               , "12239"                ,"40202"                ,"40695"
                                       ,  "10001"               , "10734"                ,"12316"                ,"KLF-93891"
                                       ,  "40286"               , "10192"                ,"40012"                ,"10552"
                                       ,  "KLF-96891"           , "KLF-500043"           ,"PG0816"               ,"12885"
                                       ,  "40588"               , "PG0860"               ,"KLF-92736"            ,"12471"
                                       ,  "40149"               , "10341"                ,"10087"                ,"PG0610"
                                       ,  "12540"
                                       ,  "40326"            ,    "10029"              ,  "40422"
                                       ,  "KLF-98590"         ,   "12010"               , "40560"                ,"KLF-99738 /100654"
                                       ,  "40339"              ,  "PG0713"               ,"40464"                ,"PG0369"
                                       ,  "KLF-99795 /800667"   , "PG0561"               ,"PG0383"               ,"KLF-100219"
                                       ,  "10258"               , "PG0464"               ,"PG0662"               ,"12740"
                                       ,  "KLF-93678"           , "12139"                ,"40157"                ,"KLF-99283 /100615"
                                       ,  "10279"                ,"PG0444"               ,"KLF-100696 /800696"   ,"40197"
                                       ,  "40474"               , "PG0378"               ,"40338"                ,"12487"
                                       ,  "PG0422"               ,"KLF-500169"           ,"KLF-94979"            ,"10357"
                                       ,  "PG0461"               ,"KLF-98145"            ,"KLF-500119"           ,"40222"
                                       ,  "10392"                ,"KLF-92464"            ,"PG0382"               ,"KLF-100597"
                                       ,  "12966"                ,"40469"                ,"PG0476"               ,"KLF-100354 /800685"
                                       ,  "10464"                ,"KLF-100299"           ,"12509"                ,"10607"
                                       ,  "10494"                ,"12462"                ,"12655"                ,"KLF-500167"
                                       ,  "KLF-500208 /500208"   ,"PG0558"               ,"12279"                ,"40158"
                                       ,  "12801"                ,"PG0722"               ,"KLF-93884"            ,"10201"
                                       ,  "12271"                ,"40521"                ,"PG0799"               ,"40485"
                                       ,  "PG0559"               ,"KLF-500318"           ,"40199"                ,"40493"
                                       ,  "12142"                ,"12156"                ,"40271"                ,"10092"
                                       ,  "12227"                ,"40699"                ,"40578"                ,"40376"
                                       ,  "10234"                ,"40208"                ,"KLF-100424"           ,"12161"
                                       ,  "12273"                ,"PG0431"               ,"KLF-93200"            ,"PG0362"
                                       ,  "10641"                ,"40445"                ,"12505"                ,"PG0447"
                                       ,  "10349"                ,"12504"                ,"40483"                ,"40065"
                                       ,  "40207"                ,"PG1497"               ,"12148"                ,"PG0404"
                                       ,  "40165"                ,"10133"                ,"12305"                ,"KLF-99010 /100611"
                                       ,  "40488"                ,"12146"                ,"PG0443"               ,"G18-038"
                                       ,  "KLF-100398"           ,"KLF-99873"            ,"10228"                ,"10396"
                                       ,  "10093"                ,"40450"                ,"12403"                ,"40520"
                                       ,  "PG0455"               ,"KLF-500121"           ,"KLF-m-500249 /500249" ,"10332"
                                       ,  "PG0526"               ,"12757"                ,"40139"                ,"12484"
                                       ,  "12261"                ,"40458"                ,"12173"                ,"12931"
                                       ,  "PG1178"               ,"12346"                ,"12248"                ,"10637"
                                       ,  "12364"                ,"40266"                ,"KLF-500122 /500122"   ,"10347"
                                       ,  "10168"                ,"KLF-95674"            ,"40447"                ,"10216"
                                       ,  "40273"                ,"KLF-97978 /100513"    ,"12481"                ,"12374"
                                       ,  "G17-075"              ,"12179"                ,"12629"                ,"40280"
                                       ,  "PG0892"               ,"10474"                ,"40131"                ,"10731"
                                       ,  "PG1160"               ,"40475"))
  
  timepoints <- timepoints %>%
    mutate(timepoint = "bl",
           stimulation = "unstim",
           study_group = "grp_1",
           tech_reps_nr = 1)
  
  metadata$timepoints <- timepoints
  
  # Provide the kitnames of the experiment.
  # THIS IS R01AI128765 SPECIFIC.
  
  kits_expected <- c("HCCBP2MAG58K",
                     "HCVD2MAG67K" ,
                     "HCVD3MAG67K",
                     "HNDG1MAG36K",
                     "R&D22plex",
                     "R&D4plex",
                     "R&D5plex")
  
  metadata$kits <- list(kits_expected = kits_expected)
  
  write_rds(metadata, "./rds/metadata.rds")
  
} else if(investigation == "mph_hiv"){
  
  # MPH-HIV ---------------------------------------------------------------
  
  metadata <- list(design = NULL,
                   data_files = NULL,
                   reruns = NULL,
                   tech = NULL,
                   timepoints = NULL,
                   kits = NULL)
  print(str(metadata))
  #tmp <- list.dirs(directory_data, full.names = FALSE) #previous code.
  tmp <- list.dirs(directory_data, 
                   recursive=F, 
                   full.names = FALSE)[which(lengths(lapply(list.dirs(directory_data, 
                                                                      recursive=F), 
                                                            list.dirs)) > 0)] #Updated code 20November2023.
  if("" %in% tmp){
    tmp <- tmp[tmp != ""]
  }
  
  tmp1 <- paste(directory_data, tmp, sep = "/")
  tmp <- list.dirs(directory_data, full.names = FALSE, recursive = FALSE)
  if("" %in% tmp){
    tmp <- tmp[tmp != ""]
  }
  
  tmp1 <- paste(directory_data, tmp, sep = "/")
  tmp1 <- list.files(tmp1, full.names = FALSE, pattern=("*[.]"))
  
  for (i in 1:length(tmp1)) {
    tmp1[i] <- sub(".txt", "\\1", basename(tmp1[i]))
  }
  tmp1 <- tibble(kit = gsub("^(.*)_[BM]P_.*","\\1", tmp1))
  tmp1 <- tmp1 %>%  group_by(kit) %>% summarise(nr_of_plates = n())
  
  metadata$data_files <- tibble(kits = tmp,
                                nr_of_plates = tmp1$nr_of_plates,
                                analytes_per_kit = NA)
  print(str(metadata))
  
  metadata$tech <- list(parts = 4, instrument_names = c("BP", "MP"))
  
  metadata$design <- tibble(tot_specimens = 196,
                            tot_subjects = 98)
  
  # Make data frame to list description with their time points and stimulation condition.
  # colnames = description, timepoint, stimulation
  
  # MPH-HIV DATA SPECIFIC
  timepoints <- tibble(description = c("01-058 D0"   ,"01-058 25W"  ,"01-061 D0"   ,"01-061 25W"  ,"01-075 D0"   ,"01-075 25W"
                                       ,"01-076 D0" ,  "01-076 25W"  ,"01-078 D0" ,  "01-078 25W"  ,"01-080 D0" ,  "01-080 25W"
                                       ,"01-082 D0" ,  "01-082 25W"  ,"01-083 D0" ,  "01-083 25W"  ,"01-084 D0" ,  "01-084 25W"
                                       ,"01-085 D0" ,  "01-085 25W"  ,"01-086 D0" ,  "01-086 25W"  ,"01-090 D0" ,  "01-090 25W"
                                       ,"01-097 D0" ,  "01-097 25W"  ,"01-099 D0" ,  "01-099 25W"  ,"01-100 D0" ,  "01-100 25W"
                                       ,"01-101 D0" ,  "01-101 25W"  ,"01-108 D0" ,  "01-108 25W"  ,"01-113 D0" ,  "01-113 25W"
                                       ,"01-008 D0" ,  "01-008 25W"  ,"01-010 D0" ,  "01-010 25W"
                                       ,"01-011 D0" ,  "01-011 25W"  ,"01-012 D0" ,  "01-012 25W"  ,"01-013 D0" ,  "01-013 25W"
                                       ,"01-014 D0" ,  "01-014 25W"  ,"01-015 D0" ,  "01-015 25W"  ,"01-016 D0" ,  "01-016 25W"
                                       ,"01-019 D0" ,  "01-019 25W"  ,"01-020 D0" ,  "01-020 25W"  ,"01-021 D0" ,  "01-021 25W"
                                       ,"01-026 D0" ,  "01-026 25W"  ,"01-027 D0" ,  "01-027 25W"  ,"01-030 D0" ,  "01-030 25W"
                                       ,"01-031 D0" ,  "01-031 25W"  ,"01-032 D0" ,  "01-032 25W"  ,"01-034 D0" ,  "01-034 25W"
                                       ,"01-035 D0" ,  "01-035 25W"  ,"01-118 D0" ,  "01-118 25W"  ,"01-120 D0" ,  "01-120 25W"
                                       ,"01-124 D0" ,  "01-124 25W"  ,"01-125 D0" ,  "01-125 25W"  ,"01-133 D0" ,  "01-133 25W"
                                       ,  "01-134 D0",   "01-134 25W",  "01-135 D0",   "01-135 25W",  "01-138 D0",   "01-138 25W"
                                       ,  "01-139 D0"   ,"01-139 25W",  "01-140 D0"   ,"01-140 25W",  "01-141 D0",   "01-141 25W"
                                       ,  "01-142 D0"   ,"01-142 25W",  "01-151 D0"   ,"01-151 25W",  "01-152 D0",   "01-152 25W"
                                       ,  "01-159 D0"   ,"01-159 25W"  ,"01-160 D0"   ,"01-160 25W",  "01-162 D0",   "01-162 25W"
                                       ,  "01-166 D0"   ,"01-166 25W"  ,"01-168 D0"   ,"01-168 25W",  "01-170 D0",   "01-170 25W"
                                       ,  "01-173 D0"   ,"01-173 25W"  ,"01-177 D0"   ,"01-177 25W",  "01-179 D0",   "01-179 25W"
                                       ,  "01-180 D0"   ,"01-180 25W"  ,"01-181 D0"   ,"01-181 25W",  "01-187 D0",   "01-187 25W"
                                       ,  "01-188 D0"   ,"01-188 25W"  ,"01-190 D0"   ,"01-190 25W",  "01-191 D0",   "01-191 25W"
                                       ,  "01-192 D0"   ,"01-192 25W"  ,"01-193 D0"   ,"01-193 25W",  "01-195 D0",   "01-195 25W"
                                       ,  "01-196 D0"   ,"01-196 25W"  ,"01-197 D0"   ,"01-197 25W",  "01-136 D0",   "01-136 25W"
                                       ,  "01-033 D0"   ,"01-033 25W"  ,"01-045 D0"   ,"01-045 25W",  "01-046 D0",   "01-046 25W"
                                       ,  "01-047 D0"   ,"01-047 25W"  ,"01-049 D0"   ,"01-049 25W",  "01-053 D0",   "01-053 25W"
                                       ,  "01-054 D0"   ,"01-054 25W"  ,"01-056 D0"   ,"01-056 25W",  "01-057 D0",   "01-057 25W"
                                       ,  "01-059 D0"   ,"01-059 25W"  ,"01-060 D0"   ,"01-060 25W",  "01-062 D0",   "01-062 25W"
                                       ,  "01-063 D0"   ,"01-063 25W"  ,"01-065 D0"   ,"01-065 25W",  "01-070 D0",   "01-070 25W"
                                       ,  "01-073 D0"   ,"01-073 25W"  ,"01-074 D0"   ,"01-074 25W",  "01-037 D0",   "01-037 25W"
                                       ,  "01-038 D0"   ,"01-038 25W"  ,"01-040 D0"   ,"01-040 25W",  "01-041 D0",   "01-041 25W"
                                       ,  "01-043 D0"   ,"01-043 25W"  ,"01-007 D0"   ,"01-007 25W",  "01-025 D0",   "01-025 25W"
                                       ,  "01-050 D0"   ,"01-050 25W"  ,"01-064 D0" ,  "01-064 25W",  "01-017 D0"
                                       , "01-017 25W" ),
                       Timepoint = case_when(str_detect(description, "D0") ~ "day_0",
                                             str_detect(description, "25W") ~ "week_25"))
  
  timepoints$description <- tolower(timepoints$description)
  timepoints$description <- gsub("\\s", "", timepoints$description, perl = TRUE)
  
  
  timepoints <- timepoints %>%
    mutate(stimulation = "unstim",
           study_group = "grp_1",
           tech_reps_nr = 2)
  
  metadata$timepoints <- timepoints
  
  # Provide the kitnames of the experiment.
  # THIS IS MPH-HIV SPECIFIC
  
  kits_expected <- c("HTH17MAG14K",
                     "HCYTOMAG60K_RANTES",
                     "HCYTOMAG60K15plex")
  
  metadata$kits <- list(kits_expected = kits_expected)
  
  # Standardize variable names to all lower case (SATBBI style).
  # cnames <- colnames(metadata) %>% str_to_lower()
  # colnames(metadata) <- cnames
  
  write_rds(metadata, "./rds/metadata.rds")
}
