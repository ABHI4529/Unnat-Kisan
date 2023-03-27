class Crop {
  List<Crops>? crops;

  Crop({this.crops});

  Crop.fromJson(Map<String, dynamic> json) {
    if (json['crops'] != null) {
      crops = <Crops>[];
      json['crops'].forEach((v) {
        crops!.add(new Crops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.crops != null) {
      data['crops'] = this.crops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Crops {
  String? cropName;
  String? cropImageUrl;
  String? cropDescription;
  List<CropSoil>? cropSoil;
  List<CropDiseases>? cropDiseases;

  Crops(
      {this.cropName,
      this.cropImageUrl,
      this.cropDescription,
      this.cropSoil,
      this.cropDiseases});

  Crops.fromJson(Map<String, dynamic> json) {
    cropName = json['crop_name'];
    cropImageUrl = json['crop_imageUrl'];
    cropDescription = json['crop_description'];
    if (json['crop_soil'] != null) {
      cropSoil = <CropSoil>[];
      json['crop_soil'].forEach((v) {
        cropSoil!.add(new CropSoil.fromJson(v));
      });
    }
    if (json['crop_diseases'] != null) {
      cropDiseases = <CropDiseases>[];
      json['crop_diseases'].forEach((v) {
        cropDiseases!.add(new CropDiseases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crop_name'] = this.cropName;
    data['crop_imageUrl'] = this.cropImageUrl;
    data['crop_description'] = this.cropDescription;
    if (this.cropSoil != null) {
      data['crop_soil'] = this.cropSoil!.map((v) => v.toJson()).toList();
    }
    if (this.cropDiseases != null) {
      data['crop_diseases'] =
          this.cropDiseases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CropSoil {
  String? soilName;
  String? soilDescription;

  CropSoil({this.soilName, this.soilDescription});

  CropSoil.fromJson(Map<String, dynamic> json) {
    soilName = json['soil_name'];
    soilDescription = json['soil_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soil_name'] = this.soilName;
    data['soil_description'] = this.soilDescription;
    return data;
  }
}

class CropDiseases {
  String? diseaseName;
  String? diseaseImageUrl;
  String? diseaseDescription;
  String? diseaseCure;

  CropDiseases(
      {this.diseaseName,
      this.diseaseImageUrl,
      this.diseaseDescription,
      this.diseaseCure});

  CropDiseases.fromJson(Map<String, dynamic> json) {
    diseaseName = json['disease_name'];
    diseaseImageUrl = json['disease_imageUrl'];
    diseaseDescription = json['disease_description'];
    diseaseCure = json['disease_cure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease_name'] = this.diseaseName;
    data['disease_imageUrl'] = this.diseaseImageUrl;
    data['disease_description'] = this.diseaseDescription;
    data['disease_cure'] = this.diseaseCure;
    return data;
  }
}