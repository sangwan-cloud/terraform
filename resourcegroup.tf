module "rg" {
  source        = "./modules/resourcegroup"
  location      = "uksouth"
  name          = "uks-lgi-test-n-rsg-quad-01"
  env           = "test"
  businessowner = "Ajay"
  projectname   = "QUAD"
  projectid     = "8752"
  costcenter    = "173410"
  team          = "test"
}