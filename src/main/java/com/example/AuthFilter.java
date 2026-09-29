package com.example;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        boolean isPublic = path.equals("/login")
                || path.equals("/login.jsp")
                || path.equals("/about.jsp")
                || path.startsWith("/css/")
                || path.startsWith("/images/");

        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("user") != null;

        if (loggedIn || isPublic) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
    }
}