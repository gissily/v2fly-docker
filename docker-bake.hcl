group "default" {
  targets = ["v2fly-core"]
}

variable "PROJECT_DIR" {
    type = string
}

variable "CI_REGISTRY" {
  type = string
}

variable "LATEST" {
  type = string
}

target "v2fly-core" {
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${CI_REGISTRY}/gissily/v2fly-core:${LATEST}", 
    "${CI_REGISTRY}/gissily/v2fly-core:latest"
    ]
}

target "v2fly-build-tools" {
  dockerfile = "Dockerfile-tools"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${CI_REGISTRY}/gissily/v2fly-core:build"
    ]
}