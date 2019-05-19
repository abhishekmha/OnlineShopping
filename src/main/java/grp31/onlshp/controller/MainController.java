package grp31.onlshp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import grp31.onlshp.model.LoginBean;
import grp31.onlshp.model.ProductBean;
import grp31.onlshp.model.PurchaseBean;
import grp31.onlshp.model.RegisterBean;
import grp31.onlshp.model.SearchBean;
import grp31.onlshp.pojo.User;
import grp31.onlshp.service.CartService;
import grp31.onlshp.service.ProductService;
import grp31.onlshp.service.UserService;

@Controller
@EnableWebMvc
public class MainController {

	private UserService userService;
	private ProductService productService;
	private CartService cartService;
	
	@Autowired(required=true)
	@Qualifier(value="productService")
	public void setProductService(ProductService ps){
		this.productService = ps;
	}
	
	@Autowired(required=true)
	@Qualifier(value="userService")
	public void setUserService(UserService us){
		this.userService = us;
	}
	
	@Autowired(required=true)
	@Qualifier(value="cartService")
	public void setcartService(CartService cs){
		this.cartService = cs;
	}
	
	
//================================ GENERAL REQUEST MAPPING =================================================

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale) {
		System.out.println("Home Page Requested, locale = " + locale);

		return "home";
	}

	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String about(Locale locale) {
		System.out.println("About Page Requested, locale = " + locale);
		return "about";
	}

	
//============================== USER REQUEST MAPPING =================================

	//==================================== LOGIN AND LOGOUT ==================================================
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("Login Page Requested");
		ModelAndView model = null;
		HttpSession session = request.getSession(true);
		String name = (String) session.getAttribute("loggedInUsername");
		
		if(session != null && name == null)
		{
			model = new ModelAndView("login");
			LoginBean loginBean = new LoginBean();
			model.addObject("loginBean", loginBean);
		}
		else {
			model = new ModelAndView("_403");
		}
			
		return model;
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public ModelAndView executeLogin(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("loginBean")LoginBean loginBean, Model msg)
	{
		ModelAndView model= null;
		try
		{
			System.out.println(loginBean.getEmail()+loginBean.getPassword());
			byte isValidUser = userService.validateLogin(loginBean.getEmail(), loginBean.getPassword());
			if(isValidUser==5)
			{
				System.out.println("User Login Successful");
//				request.setAttribute("loggedInUser", loginBean.getEmail());

				HttpSession session = request.getSession(true);
				User user = userService.getLoggedInUser(userService.getUserId(loginBean.getEmail()));
				
				System.out.println("current user - " +user);
				session.setAttribute("loggedInUsername", user.getUsername());
				session.setAttribute("loggedInUserId", user.getId());
				System.out.println(user.getType());
				session.setAttribute("loggedInUserType", user.getType());
				session.setAttribute("loggedInUser", user);
				session.setAttribute("cartTotal", 0);
				
				model = new ModelAndView("home");
			}
			else
			{
				model = new ModelAndView("login");
				model.addObject("loginBean", loginBean);
//				request.setAttribute("message", "Invalid credentials!!");
				if(isValidUser==0) {
					msg.addAttribute("msg", "Invald User! User has not yet registered or the email is Incorrect.");
				}
				else if(isValidUser==1) {
					msg.addAttribute("msg", "Incorrect password, please try again!");
				}
				else {
					throw new Exception("Something went wrong in the service");
				}
			}

		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response,HttpSession session)
	{
		System.out.println("Logout Page Requested");
		
		if(session!=null) {
			System.out.println("logging out - "+ session.getAttribute("loggedInUsername"));
			session.invalidate();
			return "logout";
		}
		else {
			return "_404";
		}
	}
	

	//==================================== REGISTER ==================================================
	
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public ModelAndView displayRegister(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("Register Page Requested");
		ModelAndView model = new ModelAndView("register");
		RegisterBean registerBean = new RegisterBean();
		HttpSession session = request.getSession(true);
		User u = (User)session.getAttribute("loggedInUser");
		if(u==null)
		{
			model.addObject("registerBean", registerBean);
		}
		else {
			model = new ModelAndView("_403");
		}
		return model;
	}
	
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public ModelAndView executeRegister(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("registerBean")RegisterBean registerBean, Model msg)
	{
		ModelAndView model= null;
		try
		{
			System.out.println(registerBean.getEmail()+registerBean.getPassword()+registerBean.getAge()+registerBean.getType());
			boolean isValidUser = userService.validateRegiser(registerBean.getEmail());
			if(isValidUser)
			{
				userService.addUser(registerBean.getUsername(),registerBean.getEmail(),registerBean.getPassword(),registerBean.getAge(),registerBean.getType());
				System.out.println("User Registration Successful");

				HttpSession session = request.getSession(true);
//				String user = registerBean.getEmail();
//				System.out.println("current user - "+user);
				String msg2 = " New User Registered ";
				session.setAttribute("event", msg2);
				model = new ModelAndView("success");			
			}
			else
			{
				model = new ModelAndView("register");
				model.addObject("registerBean", registerBean);
				msg.addAttribute("msg", "Account already exists for this Email!");
//				request.setAttribute("message", "Account already exists!!");
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return model;
	}
	
//==================================== VIEW AND DELETE ==================================================
	
	@RequestMapping(value="/deleteUser",method=RequestMethod.GET)
	public String deleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		System.out.println("User Deletion Requested");
		
		if(session!=null)
		{
			User u = (User)session.getAttribute("loggedInUser");
			System.out.println("deleting - "+ u.getEmail());
			
			userService.removeUser(u.getEmail());
			session.invalidate();
			session = request.getSession(true);
			String msg = " Account Deleted ";
			session.setAttribute("event", msg);
			return "redirect:success";
		}
		
		return "redirect:_403";
	}
	
	@RequestMapping(value="/profile",method=RequestMethod.GET)
	public String viewProfile(HttpServletRequest request, HttpServletResponse response,Model profile)
	{
		System.out.println("Profile Page Requested");
		HttpSession session = request.getSession(false);
		User u = (User)session.getAttribute("loggedInUser");
		
		if(session!=null && u!=null)
		{
			System.out.println("viewing - "+ u);
			
			Integer uid = u.getId();
			String id = uid.toString();
			profile.addAttribute("id", id);
			
			String username = u.getUsername();
			profile.addAttribute("username", username);
			
			String email = u.getEmail();
			profile.addAttribute("email", email);
			
			Integer uage = u.getAge();
			String age = uage.toString();
			profile.addAttribute("age", age);
			
			String type = u.getType();
			profile.addAttribute("type", type);
			
			return "profile";
		}
		else {
			return "_404";
		}
	}
	
	//=================================== UPDATE ============================================
	
	@RequestMapping(value="/editProfile",method=RequestMethod.GET)
	public ModelAndView displayUpdate(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("Register Page Requested");
		ModelAndView model = new ModelAndView("editProfile");
		RegisterBean registerBean = new RegisterBean();
		HttpSession session = request.getSession(false);
		User u = (User)session.getAttribute("loggedInUser");
		if(u!=null)
		{
			registerBean.setEmail(u.getEmail());
			registerBean.setPassword(u.getPassword());
			registerBean.setAge(u.getAge());
			registerBean.setType(u.getType());
			registerBean.setUsername(u.getUsername());
			model.addObject("registerBean", registerBean);
		}
		else {
			model = new ModelAndView("_403");
		}
		return model;
	}
	
	@RequestMapping(value="/editProfile",method=RequestMethod.POST)
	public ModelAndView executeUpdate(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("registerBean")RegisterBean registerBean, Model msg)
	{
		ModelAndView model= null;
		try
		{
			HttpSession session = request.getSession(false);
			User u = (User)session.getAttribute("loggedInUser");
			String oldEmail = u.getEmail();			
			String newEmail = registerBean.getEmail();
			
			System.out.println(registerBean.getUsername()+registerBean.getEmail()+registerBean.getPassword()+registerBean.getAge()+registerBean.getType());
			boolean isValidUser = userService.validateRegiser(registerBean.getEmail());
			
			if(isValidUser || oldEmail.equals(newEmail))
			{
				u.setAge(registerBean.getAge());
				u.setEmail(registerBean.getEmail());
				u.setPassword(registerBean.getPassword());
				u.setUsername(registerBean.getUsername());
				userService.updateUser(u);
				
				System.out.println("User Update Successful");
				System.out.println("current user - " +u);
				session.setAttribute("loggedInUsername", u.getUsername());
				session.setAttribute("loggedInUser", u);
				
//				String user = registerBean.getEmail();
//				System.out.println("new email - "+user);
				String msg2 = " User Profile Updated ";
				session.setAttribute("event", msg2);
				model = new ModelAndView("success");			
			}
			else
			{
				model = new ModelAndView("editProfile");
				model.addObject("registerBean", registerBean);
				msg.addAttribute("msg", "Another Account already exists for this Email!");
//				request.setAttribute("message", "Account already exists!!");
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return model;
	}

//============================== PRODUCT REQUEST MAPPING ======================================

	//============================== ADD PRODUCT ======================================

	@RequestMapping(value="/addProduct",method=RequestMethod.GET)
	public ModelAndView displayAddProduct(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("Add Product Page Requested");
		ModelAndView model=null;
		HttpSession session = request.getSession(false);
		String type = (String) session.getAttribute("loggedInUserType");
		if(type != null && type.equals("vendor")) {
			model = new ModelAndView("addProduct");
			ProductBean productBean = new ProductBean();
			model.addObject("productBean", productBean);
		}
		else {
			model = new ModelAndView("_403");
		}
		return model;
	}
	
	@RequestMapping(value="/addProduct",method=RequestMethod.POST)
	public ModelAndView executeAddProduct(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("productBean")ProductBean productBean, Model msg)
	{
		ModelAndView model= null;
		try
		{
			System.out.println("new product - "+productBean.getProductname()+productBean.getQuantity());
			System.out.println(productBean.getDescription()+productBean.getCategory()+productBean.getPrice());
			
			HttpSession session = request.getSession(false);
			User u = (User)session.getAttribute("loggedInUser");
			boolean isValidProduct = productService.validateProduct(productBean.getProductname(), u.getEmail());
			if(isValidProduct)
			{
				productService.addProduct(productBean.getProductname(), u.getEmail(), productBean.getDescription(), productBean.getQuantity(), productBean.getCategory(), productBean.getPrice());
				System.out.println("Product Registration Successful");
				
//				String product = productBean.getEmail();
//				System.out.println("current product - "+product);
				
				String msg2 = " New Product Registered ";
				session.setAttribute("event", msg2);
				model = new ModelAndView("success");			
			}
			else
			{
				model = new ModelAndView("addProduct");
				model.addObject("productBean", productBean);
				msg.addAttribute("msg", "You have already added this product!");
//				request.setAttribute("message", "Account already exists!!");
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return model;
	}
	
	//============================== LIST PRODUCTS ======================================
	
	@RequestMapping(value="/allProducts",method=RequestMethod.GET)
	public ModelAndView allProducts(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession(true);
		session.setAttribute("category", null);
		ModelAndView model = new ModelAndView("redirect:viewShop");
		PurchaseBean purchaseBean = new PurchaseBean();
		model.addObject("purchaseBean", purchaseBean);
		return model;
	}
	
//	@RequestMapping(value="/categories",method=RequestMethod.GET)
//	public ModelAndView categories(HttpServletRequest request, HttpServletResponse response)
//	{
//		HttpSession session = request.getSession(true);
//		session.setAttribute("category", null);
//		ModelAndView model = new ModelAndView("redirect:viewShop");
//		PurchaseBean purchaseBean = new PurchaseBean();
//		model.addObject("purchaseBean", purchaseBean);
//		return model;
//	}
	
	@RequestMapping(value="/viewShop",method=RequestMethod.GET)
	public ModelAndView viewShop(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("purchaseBean")PurchaseBean purchaseBean, Model list)
	{
		System.out.println("Product List Page Requested");
		ModelAndView model=null;
		HttpSession session = request.getSession(false);
		String category = (String) session.getAttribute("category");
		System.out.println("category chose - "+category);
		if(category == null) {
			model = new ModelAndView("viewShop");
			List<String> productList = productService.listProducts();
			HashMap<String, List<String>> vendorList = new HashMap<String, List<String>>();
			for(String pname : productList) {
				vendorList.put(pname, productService.listVendors(pname));
			}
			HashMap<String, String> descriptionList = new HashMap<String, String>();
			for(String pname : productList) {
				descriptionList.put(pname, productService.getDescription(pname));
			}
			HashMap<String, String> vendorNameList = new HashMap<String, String>();
			for(String pname : productList) {
				for(String vname : vendorList.get(pname)) {
					vendorNameList.put(vname, userService.getUserByEmail(vname).getUsername());
				}
			}
			list.addAttribute("descriptionList", descriptionList);
			list.addAttribute("vendorList", vendorList);
			list.addAttribute("vendorNameList", vendorNameList);
			list.addAttribute("productList", productList);
		}
		else if(category.length() > 1) {
			model = new ModelAndView("viewShop");
			List<String> productList = productService.listProductsByCategory(category);
			list.addAttribute("productList", productList);
		}
		else {
			model = new ModelAndView("_404");
		}
		return model;
	}
	
	//===================================== MAPPING BY CATEGORY ==============================
	
	@RequestMapping(value="/categories",method=RequestMethod.GET)
	public ModelAndView viewCategories(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession(true);
		session.setAttribute("category", null);
		ModelAndView model = new ModelAndView("categories");
		SearchBean searchBean = new SearchBean();
		model.addObject("searchBean", searchBean);
		return model;
	}
	
	@RequestMapping(value="/categories",method=RequestMethod.POST)
	public ModelAndView selectCategories(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchBean")SearchBean searchBean)
	{
		HttpSession session = request.getSession(true);
		session.setAttribute("category", searchBean.getParameter());
		ModelAndView model = new ModelAndView("redirect:viewShop");
		PurchaseBean purchaseBean = new PurchaseBean();
		model.addObject("purchaseBean", purchaseBean);
		return model;
	}
	
//====================================== CART MAPPING =====================================
	
	@RequestMapping(value="/addToCart",method=RequestMethod.POST)
	public ModelAndView addToCart(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("purchaseBean")PurchaseBean purchaseBean)
	{
		System.out.println("Add to cart Requested");
		ModelAndView model=null;
		HttpSession session = request.getSession(false);
		User u = (User)session.getAttribute("loggedInUser");
		if(u!=null) {
		
		System.out.println("user ID - "+u.getId());
		System.out.println("product ID - "+productService.getProductId(purchaseBean.getProductname(), purchaseBean.getVendor()));
		System.out.println("Quantity - "+purchaseBean.getQuantity());
		cartService.addToCart(u.getId(), productService.getProductId(purchaseBean.getProductname(), purchaseBean.getVendor()),purchaseBean.getQuantity());
		int count = (int) session.getAttribute("cartTotal");
		count++;
		session.setAttribute("cartTotal", count);
		System.out.println("items in cart - "+count);
		purchaseBean = new PurchaseBean();
		model = new ModelAndView("redirect:viewShop");
		model.addObject(purchaseBean);
		}
		else {
			model = new ModelAndView("login");
			LoginBean loginBean = new LoginBean();
			model.addObject("loginBean", loginBean);
		}
		return model;
	}

//============================== MISCELLANEOUS MAPPING =====================================
	
	@RequestMapping(value = "/success", method = RequestMethod.GET)
	public String success(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Success Page Requested");
		return "success";
	}
	
	@RequestMapping(value = "/_403", method = RequestMethod.GET)
	public String error_403(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Unauthorised access Requested");
		return "_403";
	}
	
	@RequestMapping(value = "/_404", method = RequestMethod.GET)
	public String error_404(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Stupid access Requested");
		return "_404";
	}
	
}
