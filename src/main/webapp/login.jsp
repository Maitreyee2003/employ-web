<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
    String error = (String) request.getAttribute("error");
    String ctx = request.getContextPath();
%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Login | EmpHub</title>
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }
                
                body {
                    font-family: 'Poppins', Arial, sans-serif;
                    color: #fff;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 24px;
                    position: relative;
                    overflow: hidden;
                    background: linear-gradient(rgba(15, 23, 42, .45), rgba(15, 23, 42, .7)), url('<%= ctx %>/images/login.jpg') center / cover no-repeat, linear-gradient(135deg, #0ea5e9, #4f46e5 55%, #7e22ce);
                }
                
                body::after {
                    content: "";
                    position: fixed;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    height: 260px;
                    pointer-events: none;
                    background: url('<%= ctx %>/images/skyline.svg') repeat-x center bottom / auto 100%;
                }
                
                .shell {
                    position: relative;
                    z-index: 1;
                    display: flex;
                    align-items: center;
                    gap: 56px;
                    width: 100%;
                    max-width: 980px;
                }
                
                .pitch {
                    flex: 1.1;
                }
                
                .brand {
                    font-size: 28px;
                    font-weight: 700;
                }
                
                .brand span {
                    color: #38bdf8;
                }
                
                .pitch h1 {
                    font-size: 44px;
                    line-height: 1.2;
                    margin: 26px 0 14px;
                }
                
                .pitch p {
                    color: #e0e7ff;
                    line-height: 1.7;
                    max-width: 430px;
                }
                
                .chips {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 10px;
                    margin-top: 24px;
                }
                
                .chips span {
                    background: rgba(255, 255, 255, .14);
                    border: 1px solid rgba(255, 255, 255, .28);
                    padding: 8px 15px;
                    border-radius: 30px;
                    font-size: 13px;
                    backdrop-filter: blur(4px);
                }
                
                .panel {
                    flex: .9;
                    background: rgba(255, 255, 255, .97);
                    color: #0f172a;
                    border-radius: 22px;
                    padding: 40px 34px;
                    box-shadow: 0 30px 60px rgba(0, 0, 0, .4);
                }
                
                .panel h2 {
                    font-size: 26px;
                }
                
                .sub {
                    color: #64748b;
                    font-size: 14px;
                    margin: 6px 0 10px;
                }
                
                label {
                    display: block;
                    margin-top: 16px;
                    font-weight: 600;
                    font-size: 14px;
                }
                
                .field {
                    position: relative;
                    margin-top: 6px;
                }
                
                .field .ico {
                    position: absolute;
                    left: 14px;
                    top: 50%;
                    transform: translateY(-50%);
                    font-size: 15px;
                }
                
                .field input {
                    width: 100%;
                    padding: 13px 44px 13px 42px;
                    border: 1px solid #cbd5e1;
                    border-radius: 10px;
                    font-size: 15px;
                    font-family: inherit;
                    background: #f8fafc;
                }
                
                .field input:focus {
                    outline: none;
                    border-color: #6366f1;
                    background: #fff;
                    box-shadow: 0 0 0 3px rgba(99, 102, 241, .2);
                }
                
                .eye {
                    position: absolute;
                    right: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                    background: none;
                    border: none;
                    cursor: pointer;
                    font-size: 16px;
                }
                
                .go {
                    width: 100%;
                    margin-top: 24px;
                    padding: 14px;
                    border: none;
                    border-radius: 10px;
                    cursor: pointer;
                    font-size: 16px;
                    font-weight: 600;
                    font-family: inherit;
                    color: #fff;
                    background: linear-gradient(135deg, #6366f1, #a855f7);
                    transition: .2s;
                }
                
                .go:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px rgba(99, 102, 241, .4);
                }
                
                .hint {
                    margin-top: 18px;
                    text-align: center;
                    font-size: 12px;
                    color: #64748b;
                    background: #f1f5f9;
                    padding: 10px;
                    border-radius: 8px;
                }
                
                .err {
                    background: #fee2e2;
                    color: #991b1b;
                    border: 1px solid #fca5a5;
                    padding: 12px 14px;
                    border-radius: 10px;
                    font-size: 14px;
                    font-weight: 600;
                    margin: 10px 0 0;
                }
                
                .back {
                    display: block;
                    text-align: center;
                    margin-top: 14px;
                    font-size: 13px;
                    color: #6366f1;
                    text-decoration: none;
                }
                
                @media (max-width: 800px) {
                    .pitch {
                        display: none;
                    }
                    .shell {
                        justify-content: center;
                    }
                    .panel {
                        max-width: 420px;
                    }
                }
            </style>
        </head>

        <body>
            <div class="shell">

                <div class="pitch">
                    <div class="brand">Emp<span>Hub</span></div>
                    <h1>Your people,<br>all in one place.</h1>
                    <p>Add, update and organise your team from one clean dashboard. Search instantly, sort in a click and export to CSV whenever you need it.</p>
                    <div class="chips">
                        <span>🔐 Secure login</span>
                        <span>🔍 Instant search</span>
                        <span>📊 Live stats</span>
                        <span>⬇ CSV export</span>
                    </div>
                </div>

                <div class="panel">
                    <h2>Welcome back 👋</h2>
                    <p class="sub">Sign in to your admin account</p>

                    <% if (error != null) { %>
                        <div class="err">
                            <%= error %>
                        </div>
                        <% } %>

                            <form action="login" method="post">
                                <label>Username</label>
                                <div class="field">
                                    <span class="ico">👤</span>
                                    <input type="text" name="username" required placeholder="Enter username" autofocus>
                                </div>

                                <label>Password</label>
                                <div class="field">
                                    <span class="ico">🔒</span>
                                    <input type="password" name="password" id="pw" required placeholder="Enter password">
                                    <button type="button" class="eye" onclick="togglePw()" title="Show / hide password">👁</button>
                                </div>

                                <button type="submit" class="go">Sign In</button>
                            </form>

                            <div class="hint">Demo login: <b>admin</b> / <b>admin123</b></div>
                            <a class="back" href="<%= ctx %>/about.jsp">About this project</a>
                </div>
            </div>

            <script>
                function togglePw() {
                    var p = document.getElementById('pw');
                    p.type = p.type === 'password' ? 'text' : 'password';
                }
            </script>
        </body>

        </html>