<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${note.title}</title>
    <link href="/vendor/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container">
        <div class="page-header">
            <h1>${note.title}</h1>
        </div>
        <pre>${note.text}</pre>
    </div>
    <footer class="footer">
        <div class="container">
            <i class="glyphicon glyphicon-tags"></i>
            <#list note.tags as tag>
                 ${tag};
            </#list>
        </div>
    </footer>
</body>
</html>
