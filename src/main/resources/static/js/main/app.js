var app = angular.module("NotesApplication", ["mgcrea.ngStrap", "ngAnimate", "hljs", "relativeDate", "btford.markdown"]);

app.constant('moment', moment);
//ngTimeRelative(app);

app.config(["$locationProvider", function($locationProvider) {
    $locationProvider.html5Mode(true).hashPrefix('!');
}]);

app.controller("NavbarController", ["$scope", "$rootScope", "$http", function($scope, $rootScope, $http) {
    $scope.reload = function() {
        $rootScope.$broadcast("updateNeeded");
    };

    $scope.logout = function() {
        $http({
            "url": "/logout",
            "method": "POST"
        })
        .success(function () {
            window.location = "/"
        });
    };
}]);

app.controller("AppController", ["$scope", "$location", function($scope, $location) {
    $scope.selectedNote = null;
    $scope.selectedTag = null;

    $scope.selectNote = function(noteId) {
        if (!noteId || (noteId === $scope.selectedNote)) {
            $scope.selectedNote = null;
        } else {
            $scope.selectedNote = noteId;
        }
        $location.search("note", $scope.selectedNote);
        $scope.$broadcast("activeNote", noteId);
    };

    $scope.selectTag = function(tag) {
        $scope.selectedTag = tag;
        $scope.selectedNote = null;
        $location.search("tag", tag);
        $location.search("note", null);
        $scope.$broadcast("selectedTag", tag);
        $scope.$broadcast("activeNote", null);
    };


    {
        var locationSearch = $location.search();
        var tag = locationSearch["tag"];
        if (tag) {
            $scope.selectedTag = tag;
        }
        var selectedNote = locationSearch["note"];
        if (selectedNote) {
            $scope.selectedNote = parseInt(selectedNote);
        }
    };
}]);

app.controller("TagsController", ["$scope", "$http", function($scope, $http) {
    $scope.tags = [];

    var load = function() {
        $http({
            "url": "/api/tags",
            "method": "GET"
        })
        .success(function(data){
            var newTags = [];
            angular.forEach(data, function(e) {
                newTags.push({
                    "name": e[0],
                    "count": e[1]
                });
            });
            $scope.tags = newTags;
        });
    };

    $scope.$on("updateNeeded", function() {
        load();
    });

    load();
}]);

app.controller("NoteListController", ["$scope", "$http", "$location", function($scope, $http, $location) {
    $scope.notes = [];
    $scope.currentPage = 0;
    $scope.totalPages = null;

    var load = function(tag) {
        var params = {};
        if (tag) {
            params["tag"] = tag;
        }
        if ($scope.currentPage) {
            params["page"] = $scope.currentPage;
        }
        $http({
            "url": "/api/notes",
            "method": "GET",
            "params": params
        })
            .success(function (data) {
                $scope.notes = data.content;
                $scope.page = data.number;
                $scope.totalPages = data.totalPages;
                $location.search("page", $scope.page);
            });
    };

    $scope.isLastPage = function() {
        return ($scope.currentPage+1) === $scope.totalPages;
    };

    $scope.isFirstPage = function() {
        return $scope.currentPage === 0;
    };

    $scope.nextPage = function() {
        if (($scope.currentPage+1) < $scope.totalPages) {
            $scope.selectNote(null);
            $scope.currentPage++;
            load();
        }
    };

    $scope.previousPage = function() {
        if ($scope.currentPage !== 0) {
            $scope.selectNote(null);
            $scope.currentPage--;
            load();
        }
    };

    $scope.$on("selectedTag", function (evt, tag) {
        $scope.currentPage = 0;
        $scope.totalPages = null;
        load(tag);
    });

    $scope.$on("updateNeeded", function() {
        load($scope.selectedTag);
    });

    {
        var page = $location.search()["page"];
        if (page) {
            $scope.currentPage = parseInt(page);
        }
        load($scope.selectedTag);
    }
}]);

app.controller("NoteViewController", ["$scope", "$rootScope", "$http", "$modal", function($scope, $rootScope, $http, $modal) {
    $scope.note = null;
    var load = function(id) {
        $http({
            "url": "/api/note/"+id,
            "method": "GET"
        })
        .success(function (data) {
            $scope.note = data;
        });
    };

    $scope.$on("activeNote", function(evt, note) {
        if (note) {
            load(note);
        } else {
            $scope.note = null;
        }
    });

    $scope.$on("noteUpdated", function(evt, note) {
        if ($scope.note.id === note.id) {
            $scope.note = note;
        }
    });

    {
        if ($scope.selectedNote) {
            load($scope.selectedNote);
        }
    }

    $scope.requestDelete = function () {
        if (confirm("Вы точно хотите удалить эту заметку?")) {
            $http({
                "url": "/api/note/"+$scope.note.id,
                "method": "DELETE"
            })
            .success(function (data) {
                $scope.selectNote(null);
                $rootScope.$broadcast("updateNeeded");
            });
        }
    };

    $scope.edit = function() {
        var myModal = $modal(
            {
                template: 'edit_note.html',
                scope: $scope
            }
        );
    };
}]);

app.controller("ComposeNoteController", ["$scope", "$rootScope", "$http", function($scope, $rootScope, $http) {
    $scope.input = {
        "title": "",
        "tags": [],
        "text": "",
        "type": "PLAIN"
    };

    $scope.submit = function() {
        $http({
            "url": "/api/note",
            "method": "POST",
            "data": $scope.input
        })
        .success(function () {
            $rootScope.$broadcast("updateNeeded");
            $scope.$hide();
        });
    };
}]);

app.controller("EditNoteController", ["$scope", "$rootScope", "$http", function($scope, $rootScope, $http) {
    $scope.input = {
        "title": $scope.note.title,
        "tags": $scope.note.tags.slice(),
        "text": $scope.note.text,
        "type": $scope.note.type
    };

    $scope.submit = function() {
        $http({
            "url": "/api/note/"+$scope.note.id,
            "method": "POST",
            "data": $scope.input
        })
        .success(function (data) {
            $rootScope.$broadcast("updateNeeded");
            $scope.$emit("noteUpdated", data);
            $scope.$hide();
        });
    };
}]);
