package grp31.onlshp.model;

public class RegisterBean {

	private int age;

	private String username;
	private String email;
	private String password;
	private String password2;
	private String type;
	
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	@Override
	public String toString() {
		return "RegisterBean [age=" + age + ", username=" + username + ", email=" + email + ", password=" + password
				+ ", password2=" + password2 + ", type=" + type + "]";
	}
	
}
