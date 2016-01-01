<#import "spring.ftl" as spring />

<html>
<head>
    <link href="/vendor/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" style="margin-top: 100px">
    <div class="col-xs-offset-1 col-md-offset-2 col-lg-offset-3 col-sm-10 col-md-8 col-lg-6">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Регистрация</h3>
            </div>
            <div class="panel-body">
                <form action="/register" method="post" class="form-horizontal">
                    <@spring.bind "val.username"/>
                    <div class="form-group ${spring.status.error?then('has-error', '')} form-group">
                        <label for="${spring.status.expression}" class="col-sm-2 control-label">Имя</label>
                        <div class="col-sm-10">
                            <input type="text"
                                name="${spring.status.expression}"
                                id="${spring.status.expression}"
                                value="${spring.status.value?default("")}"
                                class="form-control"
                                />
                            <#list spring.status.errorMessages as error>
                                <span class="help-block">${error}</span>
                            </#list>
                        </div>
                    </div>

                    <@spring.bind "val.password"/>
                    <div class="form-group ${spring.status.error?then('has-error', '')} form-group">
                        <label for="${spring.status.expression}" class="col-sm-2 control-label">Пароль</label>
                        <div class="col-sm-10">
                            <input type="password"
                                name="${spring.status.expression}"
                                id="${spring.status.expression}"
                                value="${spring.status.value?default("")}"
                                class="form-control"
                                />
                            <#list spring.status.errorMessages as error>
                                <span class="help-block">${error}</span>
                            </#list>
                        </div>
                    </div>

                    <@spring.bind "val.email"/>
                    <div class="form-group ${spring.status.error?then('has-error', '')} form-group">
                        <label for="${spring.status.expression}" class="col-sm-2 control-label">E-mail</label>
                        <div class="col-sm-10">
                            <input type="email"
                                name="${spring.status.expression}"
                                id="${spring.status.expression}"
                                value="${spring.status.value?default("")}"
                                class="form-control"
                                />
                            <#list spring.status.errorMessages as error>
                                <span class="help-block">${error}</span>
                            </#list>
                        </div>
                    </div>

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <button type="submit" class="btn btn-default">Зарегистрироваться</button>
                            <a class="btn btn-link pull-right" href="/login.html">Войти</a>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
</body>
</html>
