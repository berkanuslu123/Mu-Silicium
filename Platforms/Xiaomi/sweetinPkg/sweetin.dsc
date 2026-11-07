# Sweetin (Redmi Note 10 Pro, M2101K6P) - UEFI Platform Package
# Taban: suryaPkg / sweet_k6aPkg (Project-Silicium Mu-Silicium)
# Ikili dosya kaynagi: Binaries/sweet_k6a (SM7150-AC ayisi; K6 panel destegi birebir mevcut)
# Panel: dsi_k6_38_0c_0a_fhd_dsc_video (bibir dogrulandi)
# Dokunmatik: Goodix (GT9896/GTP ailesi)
##
[Defines]
  PLATFORM_NAME                  = sweetin
  PLATFORM_GUID                  = 4B6E27A1-93D5-4B4C-8F2E-1D5A9E7C40B6
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/sweetinPkg
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = RELEASE|DEBUG
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = sweetinPkg/sweetin.fdf
  USE_CUSTOM_DISPLAY_DRIVER      = 0

  #
  # 0 = SM7150
  # 1 = SM7150-AB
  # 2 = SM7150-AC  (Snapdragon 732G - sweetin bu sinifta)
  #
  SOC_TYPE                       = 2

!include MooreaPkg/MooreaPkg.dsc.inc

[PcdsFixedAtBuild]
  #
  # DDR Memory
  #
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x80000000

  #
  # UEFI Stack
  #
  gArmPlatformTokenSpaceGuid.PcdCPUCoresStackBase|0x9FF90000
  gArmPlatformTokenSpaceGuid.PcdCPUCorePrimaryStackSize|0x40000

  #
  # SMBIOS
  #
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemManufacturer|"Xiaomi"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemModel|"Redmi Note 10 Pro"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemRetailModel|"sweetin"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemRetailSku|"Redmi_Note_10_Pro_sweetin"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemBoardModel|"Redmi Note 10 Pro"

  #
  # Simple Frame Buffer
  #
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferWidth|1080
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferHeight|2400
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferColorDepth|32

  #
  # Platform PEI
  #
  gQcomPkgTokenSpaceGuid.PcdPlatformType|"LA"

  #
  # Boot text "sessiz mod" (okunabilirlik): DEBUG_ERROR (bit31) + DEBUG_WARN (bit2).
  # Daikkana: bu fork'un DebugLib.h bitleri farkli (DEBUG_ERROR=0x80000000,
  # DEBUG_LOAD=0x4, DEBUG_INFO=0x40). DxeCore "Loading driver at ..." satirini
  # DEBUG_INFO|DEBUG_LOAD ile basar -> INFO acik kalirsa spam DEVAM eder.
  # Bu yuzden INFO da kapali; yalniz ERROR+WARN. UFS/USB hata satirlari ikili
  # surucu magmasindan gelir (kendi cevrilmis maskeleri ERROR bitli) -> kaybolmaz.
  #
  gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x80000003

[LibraryClasses]
  #
  # Memory Libraries
  #
  MemoryMapLib|sweetinPkg/Library/MemoryMapLib/MemoryMapLib.inf

  #
  # QCOM Libraries
  #
  ConfigurationMapLib|sweetinPkg/Library/ConfigurationMapLib/ConfigurationMapLib.inf

[Components]
  #
  # ACPI Tables (Asama 2 - Windows boot icin eklenecek; ilk calistirma testinde kullanilmiyor)
  #
  #sweetin/AcpiTables.inf
