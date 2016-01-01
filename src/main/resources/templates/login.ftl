<html ng-app>
    <head>
        <link href="/vendor/css/bootstrap.min.css" rel="stylesheet">
    </head>
<body>

<div class="container" style="margin-top: 100px">
    <div class="col-xs-offset-1 col-md-offset-2 col-lg-offset-3 col-sm-10 col-md-8 col-lg-6">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Войти</h3>
            </div>
            <div class="panel-body">
                <#if error.isPresent()>
                    <div class="alert alert-warning">Неверное имя пользователя или пароль.</div>
                </#if>
                <form class="form-horizontal" action="/login" method="post">
                    <div class="form-group">
                        <label for="inputName" class="col-sm-2 control-label">Имя</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="inputName" placeholder="Имя">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-2 control-label">Пароль</label>
                        <div class="col-sm-10">
                            <input type="password" name="password" class="form-control" id="inputPassword" placeholder="Пароль">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="remember-me"> Запомнить
                                </label>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <button type="submit" class="btn btn-default">Войти</button>
                            <a class="btn btn-link pull-right" href="/register">Регистрация</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>