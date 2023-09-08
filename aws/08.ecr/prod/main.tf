module "ecr-finder-compiler-api" {
  source               = "../module"
  name                 = "finder-compiler-api"
  image_tag_mutability = "IMMUTABLE"
  studio               = "hq"
  service              = "finder"
}

module "ecr-finder-api" {
  source               = "../module"
  name                 = "finder-api"
  image_tag_mutability = "IMMUTABLE"
  studio               = "hq"
  service              = "finder"
}

module "ecr-finder-oapi" {
  source               = "../module"
  name                 = "finder-oapi"
  image_tag_mutability = "IMMUTABLE"
  studio               = "hq"
  service              = "finder"
}

module "ecr-finder-worker" {
  source               = "../module"
  name                 = "finder-worker"
  image_tag_mutability = "IMMUTABLE"
  studio               = "hq"
  service              = "finder"
}

module "ecr-finder-web" {
  source               = "../module"
  name                 = "finder-web"
  image_tag_mutability = "IMMUTABLE"
  studio               = "hq"
  service              = "finder"
}
