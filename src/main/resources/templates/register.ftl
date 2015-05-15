<form action="/register" method="post">
    <input type="text" name="name" placeholder="username"/>
    <input type="password" name="password" placeholder="password"/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="submit" />
</form>