<!DOCTYPE HTML>

<html ng-app="NotesApplication">

<head>
    <title>Notes</title>

    <base href="/">
    <meta name="viewport" content="width=device-width, height = device-height, user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="/vendor/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/vendor/css/angular-motion.min.css"/>
    <link rel="stylesheet" type="text/css" href="/vendor/css/highlightjs-github.css"/>
    <link rel="stylesheet" type="text/css" href="/vendor/css/markdown.css"/>
    <link rel="stylesheet" type="text/css" href="/css/notes.css"/>

    <script type="text/javascript" src="/vendor/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/vendor/js/moment.js"></script>
    <script type="text/javascript" src="/vendor/js/highlight.js"></script>
    <script type="text/javascript" src="/vendor/js/showdown.js"></script>
    <script type="text/javascript" src="/vendor/js/angular.min.js"></script>
    <script type="text/javascript" src="/vendor/js/angular-sanitize.js"></script>
    <script type="text/javascript" src="/vendor/js/angular-highlightjs.js"></script>
    <script type="text/javascript" src="/vendor/js/angular-relative-date.js"></script>
    <script type="text/javascript" src="/vendor/js/angular-animate.min.js"></script>
    <script type="text/javascript" src="/vendor/js/angular-strap.min.js"></script>
    <script type="text/javascript" src="/vendor/js/angular-strap.tpl.min.js"></script>
    <script type="text/javascript" src="/vendor/js/angular-markdown.js"></script>
    <script type="text/javascript" src="/js/main/app.js"></script>
</head>
<body>
<script type="text/ng-template" id="compose_note.html">
    <div class="modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" ng-controller="ComposeNoteController">
                <div class="modal-header">
                    <button type="button" class="close" aria-label="Close" ng-click="$hide()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">
                        Новая заметка
                    </h4>
                </div>
                <form name="form" ng-submit="submit()">
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group" ng-class="{'has-error': form.title.$invalid && form.title.$dirty, 'has-success': !form.title.$invalid}">
                                <label for="inputTitle" class="col-sm-2 control-label">Заголовок</label>
                                <div class="col-sm-10">
                                    <input
                                            name="title"
                                            type="text"
                                            class="form-control"
                                            id="inputTitle"
                                            placeholder="Заголовок"
                                            ng-model="input.title"
                                            required
                                            minLength="4"
                                            maxLength="64"
                                            >
                                </div>
                            </div>
                            <div class="form-group" ng-class="{'has-error': form.text.$invalid && form.text.$dirty, 'has-success': !form.text.$invalid}">
                                <label for="inputText" class="col-sm-2 control-label">Текст</label>
                                <div class="col-sm-10">
                                    <textarea
                                            name="text"
                                            ng-model="input.text"
                                            style="resize: vertical"
                                            class="form-control"
                                            id="inputText"
                                            placeholder="Текст заметки"
                                            maxLength="128000"
                                            required
                                            >
                                    </textarea>
                                </div>
                            </div>
                            <div class="form-group" ng-class="{'has-error': form.tags.$invalid && form.tags.$dirty, 'has-success': !form.tags.$invalid}">
                                <label for="inputTags" class="col-sm-2 control-label">Теги</label>
                                <div class="col-sm-10">
                                    <input
                                            name="tags"
                                            required
                                            ng-model="input.tags"
                                            ng-list
                                            type="text"
                                            class="form-control"
                                            id="inputTags"
                                            placeholder="Теги">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputType" class="col-sm-2 control-label">Тип</label>
                                <div class="col-sm-10">
                                    <select ng-model="input.type" class="form-control" id="inputType">
                                        <option value="PLAIN">простой текст</option>
                                        <option value="CODE">код</option>
                                        <option value="MARKDOWN">markdown</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" ng-click="$hide()">Закрыть</button>
                        <button type="submit" class="btn btn-primary" ng-disabled="form.$invalid">Сохранить</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</script>

<script type="text/ng-template" id="edit_note.html">
    <div class="modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" ng-controller="EditNoteController">
                <div class="modal-header">
                    <button type="button" class="close" aria-label="Close" ng-click="$hide()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">
                        Изменить заметку
                    </h4>
                </div>
                <form name="form" ng-submit="submit()">
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group" ng-class="{'has-error': form.title.$invalid && form.title.$dirty, 'has-success': !form.title.$invalid}">
                                <label for="inputTitle" class="col-sm-2 control-label">Заголовок</label>
                                <div class="col-sm-10">
                                    <input
                                            name="title"
                                            type="text"
                                            class="form-control"
                                            id="inputTitle"
                                            placeholder="Заголовок"
                                            ng-model="input.title"
                                            required
                                            minLength="4"
                                            maxLength="64"
                                            >
                                </div>
                            </div>
                            <div class="form-group" ng-class="{'has-error': form.text.$invalid && form.text.$dirty, 'has-success': !form.text.$invalid}">
                                <label for="inputText" class="col-sm-2 control-label">Текст</label>
                                <div class="col-sm-10">
                                    <textarea
                                            name="text"
                                            ng-model="input.text"
                                            style="resize: vertical"
                                            class="form-control"
                                            id="inputText"
                                            placeholder="Текст заметки"
                                            maxLength="128000"
                                            required
                                            >
                                    </textarea>
                                </div>
                            </div>
                            <div class="form-group" ng-class="{'has-error': form.tags.$invalid && form.tags.$dirty, 'has-success': !form.tags.$invalid}">
                                <label for="inputTags" class="col-sm-2 control-label">Теги</label>
                                <div class="col-sm-10">
                                    <input
                                            name="tags"
                                            required
                                            ng-model="input.tags"
                                            ng-list
                                            type="text"
                                            class="form-control"
                                            id="inputTags"
                                            placeholder="Теги">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputType" class="col-sm-2 control-label">Тип</label>
                                <div class="col-sm-10">
                                    <select ng-model="input.type" class="form-control" id="inputType">
                                        <option value="PLAIN">простой текст</option>
                                        <option value="CODE">код</option>
                                        <option value="MARKDOWN">markdown</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" ng-click="$hide()">Закрыть</button>
                        <button type="submit" class="btn btn-primary" ng-disabled="form.$invalid">Сохранить</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</script>

<nav class="navbar navbar-default" ng-controller="NavbarController">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="" ng-click="reload()">Notes</a>
        </div>

        <ul class="nav navbar-nav">
            <li>
                <a
                        href=""
                        data-container="body"
                        data-template="compose_note.html"
                        data-animation="am-fade-and-scale"
                        bs-modal="">
                    Новая заметека
                </a>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li>
                <a href="" ng-click="logout()">
                    Выйти
                </a>
            </li>
        </ul>
        <!--form class="navbar-form navbar-right" role="search">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Поиск">
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-default">
                        <i class="glyphicon glyphicon-search"></i>
                    </button>
                </div>
            </div>
        </form-->
    </div>
</nav>

<div class="container-fluid" ng-controller="AppController">
    <div class="col-lg-2 col-md-2 col-sm-4 col-xs-5" ng-controller="TagsController" ng-class="{'hidden-xs hidden-sm': selectedNote}">
        <div class="panel panel-default">
            <div class="list-group" ng-if="tags.length > 0">
                <a href=""
                   class="list-group-item"
                   ng-click="selectTag(null)"
                   ng-class="{'active': selectedTag === null}">
                    show all notes
                </a>
                <a href=""
                   class="list-group-item"
                   ng-repeat="tag in tags"
                   ng-click="selectTag(tag.name)"
                   ng-class="{'active': selectedTag === tag.name}">
                    {{tag.name}} <span class="badge">{{tag.count}}</span>
                </a>
            </div>
            <div class="panel-body" ng-if="tags.length === 0">
                <div class="alert alert-info">
                    no tags to show
                </div>
            </div>
        </div>
    </div>

    <div class="noteList" ng-controller="NoteListController" ng-class="{'hidden-xs col-sm-6 col-md-5 col-lg-4 hasActiveNote': selectedNote, 'col-xs-7 col-sm-8 col-md-10': !selectedNote}">
        <div class="panel panel-default">
            <div class="list-group" ng-if="notes.length > 0">
                <a href=""
                   class="list-group-item"
                   ng-repeat="note in notes"
                   ng-class="{'active': selectedNote===note.id}"
                   ng-click="selectNote(note.id)">
                    <h4 class="list-group-item-heading" style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
                        <small ng-switch="note.type">
                            <span ng-switch-when="CODE" class="glyphicon glyphicon-file"></span>
                            <span ng-switch-when="MARKDOWN" class="markdown-mark"></span>
                        </small>
                        {{note.title}}
                        <small class="pull-right hidden-sm hidden-xs">{{note.lastModified | relativeDate}}</small>
                    </h4>
                </a>
            </div>
            <div class="panel-body" ng-if="notes.length === 0">
                <div class="alert alert-info">
                    nothing to show
                </div>
            </div>
        </div>
        <nav ng-if="!(isLastPage() && isFirstPage())">
            <ul class="pager">
                <li class="previous" ng-class="{'disabled': isFirstPage()}">
                    <a href="" ng-click="previousPage()"><span aria-hidden="true">&larr;</span> Туда</a>
                </li>
                <li class="next" ng-class="{'disabled': isLastPage()}">
                    <a href="" ng-click="nextPage()">Сюда <span aria-hidden="true">&rarr;</span></a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="noteView col-sm-6 col-md-5 col-lg-6" ng-controller="NoteViewController" ng-show="selectedNote">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title" style="word-break: break-word;">
                    {{note.title}}
                    <button type="button" class="close pull-right" aria-label="Close" ng-click="selectNote(null)">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </h3>
            </div>
            <div class="panel-body">
                <div ng-if="note.type === 'PLAIN'">
                    <div class="well">{{note.text}}</div>
                </div>
                <div ng-if="note.type === 'CODE'" hljs source="note.text">
                </div>
                <div ng-if="note.type === 'MARKDOWN'">
                    <div class="well" btf-markdown="note.text"></div>
                </div>
                <span class="glyphicon glyphicon-tags"></span>
                <span ng-repeat="tag in note.tags" style="margin-left:.5em;" class="label label-primary">{{tag}}</span>
            </div>
            <div class="panel-footer">
                <div type="button" class="btn btn-xs btn-danger" ng-click="requestDelete()">
                    <span class="glyphicon glyphicon-trash"></span> удалить
                </div>
                <div type="button" class="btn btn-xs btn-success pull-right" ng-click="edit()">
                    <span class="glyphicon glyphicon-pencil"></span> редактировать
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>