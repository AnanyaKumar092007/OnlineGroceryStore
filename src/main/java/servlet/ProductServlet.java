package servlet;

import dao.ProductDAO;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        try {
            if ("buy".equals(action)) {
                // Customer clicked Buy
                int productId = Integer.parseInt(request.getParameter("productId"));
                productDAO.buyProduct(productId);
            } 
            else if ("add".equals(action)) {
                // Admin added a new product
                String name = request.getParameter("name");
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                String unitType = request.getParameter("unitType");

                if (price >= 0 && stock >= 0) {
                    Product product = new Product(name, categoryId, price, stock, unitType);
                    productDAO.addProduct(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Refresh the page to show updated stock
        response.sendRedirect("products");
    }
}