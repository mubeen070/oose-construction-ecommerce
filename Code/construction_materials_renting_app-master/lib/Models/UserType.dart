class UserType {
  bool user = false;
  bool superAdmin = false;
  bool none = false;
  bool pendingAdmin = false;
  bool blocked = false;

  UserType(
      {this.user = false,
        this.superAdmin = false,
        this.none = false,
        this.pendingAdmin = false,
        this.blocked = false});

  UserType.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    superAdmin = json['superAdmin'];
    none = json['none'];
    pendingAdmin = json['pendingAdmin'];
    blocked = json['blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['superAdmin'] = this.superAdmin;
    data['none'] = this.none;
    data['pendingAdmin'] = this.pendingAdmin;
    data['blocked'] = this.blocked;
    return data;
  }

  UserType instance(String type) {
    if (type == "user")
      return UserType(user: true);
    else if (type == "superAdmin")
      return UserType(superAdmin: true);
    else if (type == "pendingAdmin")
      return UserType(pendingAdmin: true);
    else if (type == "blocked")
      return UserType(blocked: true);
    else
      return UserType(none: true);
  }
}
