class Role {
  final int roleId;
  final String roleName;

  Role(this.roleId, this.roleName);

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(json['roleId'], json['roleName']);
  }
}