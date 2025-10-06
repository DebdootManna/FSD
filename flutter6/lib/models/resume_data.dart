
class ResumeData {
  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  List<Education> education = [];
  List<Experience> experience = [];
  List<String> skills = [];
}

class Education {
  String school;
  String degree;
  String startYear;
  String endYear;

  Education({
    this.school = '',
    this.degree = '',
    this.startYear = '',
    this.endYear = '',
  });
}

class Experience {
  String company;
  String position;
  String startYear;
  String endYear;

  Experience({
    this.company = '',
    this.position = '',
    this.startYear = '',
    this.endYear = '',
  });
}
