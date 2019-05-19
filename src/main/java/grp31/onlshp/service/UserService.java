package grp31.onlshp.service;

import java.sql.SQLException;
import java.util.List;

import grp31.onlshp.pojo.User;

public interface UserService {

	void removeUser(String email);

	List<User> listUsers();

	void updateUser(User p);

	byte validateLogin(String email, String password) throws SQLException;

	boolean validateRegiser(String email) throws SQLException;

	void addUser(String username, String email, String password, int age, String type);

	User getLoggedInUser(int id);

	int getUserId(String email);

	User getUserByEmail(String ven);
}
