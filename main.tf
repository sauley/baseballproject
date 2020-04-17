provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region = var.region
  zone = var.zone
}

resource "google_compute_disk" "database" {
  name  = "baseball-stats-db"
  type  = "pd-standard"
  zone  = var.zone
  size  = 5
}

resource "google_compute_attached_disk" "attach-stats" {
  disk     = google_compute_disk.database.self_link
  instance = google_compute_instance.vm_instance.self_link
}

resource "google_compute_instance" "vm_instance" {
	name         = "baseball-instance"
	machine_type = var.machine_type

	boot_disk {
	  initialize_params {
	    image = "projects/cloud-engineer-studies/global/images/docker-stuff-image"
	  }
	}
	
	network_interface {
      network = "default"
	}  

}