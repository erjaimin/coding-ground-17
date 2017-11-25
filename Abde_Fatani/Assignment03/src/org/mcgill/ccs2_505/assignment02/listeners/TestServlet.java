package org.mcgill.ccs2_505.assignment02.listeners;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequestAttributeEvent;
import javax.servlet.ServletRequestAttributeListener;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet implements ServletRequestAttributeListener{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setAttribute("area" , "438" ) ;
		req.setAttribute( "major" , "990" ) ;
		req.setAttribute( "minor", "5712" ) ;
		RequestDispatcher dispatch = req.getRequestDispatcher(response.encodeURL("/test.jsp"));
		dispatch.forward(req, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	@Override
	public void attributeAdded(ServletRequestAttributeEvent ev) {
		System.out.println(" A: " + ev.getName() + "->" + ev.getValue ()) ;
		
	}

	@Override
	public void attributeRemoved(ServletRequestAttributeEvent ev) {
		System.out.println(" M: " + ev.getName() + "->" + ev.getValue ()) ;
		
	}

	@Override
	public void attributeReplaced(ServletRequestAttributeEvent ev) {
		System.out.println(" P: " + ev.getName() + "->" + ev.getValue ()) ;
		
	}

}
