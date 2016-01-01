package lexek.notes.controllers.api;

import com.fasterxml.jackson.annotation.JsonView;
import lexek.notes.dao.NoteRepository;
import lexek.notes.models.Note;
import lexek.notes.models.User;
import lexek.notes.models.form.NoteForm;
import lexek.notes.views.json.NoteSummary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Date;

@RestController
public class NoteController {
    private final NoteRepository noteRepository;

    @Autowired
    public NoteController(NoteRepository noteRepository) {
        this.noteRepository = noteRepository;
    }

    @RequestMapping(value = "/api/note", method = RequestMethod.POST)
    public ResponseEntity addNote(
            @AuthenticationPrincipal(errorOnInvalidType = true) User user,
            @Valid @RequestBody NoteForm form
    ) {
        Note note = new Note(
                form.getTitle(),
                form.getType(),
                new Date(),
                form.getTags(),
                form.getText(),
                user);
        noteRepository.save(note);
        return ResponseEntity.ok(note);
    }

    @RequestMapping(value = "/api/note/{id}", method = RequestMethod.POST)
    public ResponseEntity updateNote(
            @AuthenticationPrincipal User user,
            @PathVariable("id") Note note,
            @Valid @RequestBody NoteForm form
    ) {
        if (note.getOwner().getId().equals(user.getId())) {
            note.setLastModified(new Date());
            note.setTags(form.getTags());
            note.setText(form.getText());
            note.setTitle(form.getTitle());
            note.setType(form.getType());
            noteRepository.save(note);
            return ResponseEntity.ok(note);
        } else {
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        }
    }

    @RequestMapping(value = "/api/note/{id}", method = RequestMethod.GET)
    public ResponseEntity getNote(
            @AuthenticationPrincipal User user,
            @PathVariable("id") Note note
    ) {
        if (note.getOwner().getId().equals(user.getId())) {
            return ResponseEntity.ok(note);
        } else {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
    }

    @RequestMapping(value = "/api/note/{id}", method = RequestMethod.DELETE)
    public ResponseEntity deleteNote(
            @AuthenticationPrincipal User user,
            @PathVariable("id") Note note
    ) {
        if (note.getOwner().getId().equals(user.getId())) {
            noteRepository.delete(note);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
    }

    @RequestMapping(value = "/api/notes", method = RequestMethod.GET, produces = "application/json")
    @JsonView(NoteSummary.class)
    public Object getNotes(
            @AuthenticationPrincipal User user,
            @PageableDefault(page = 0, size = 15, sort = "lastModified", direction = Sort.Direction.DESC) Pageable pageable,
            @RequestParam(value = "tag", required = false) String tag
    ) {
        if (tag == null) {
            return ResponseEntity.ok(noteRepository.findByOwner(user, pageable));
        } else {
            return ResponseEntity.ok(noteRepository.findByOwnerAndTags(user, tag, pageable));
        }
    }

    @RequestMapping(value = "/api/tags", method = RequestMethod.GET)
    public Object getTags(@AuthenticationPrincipal User user) {
        return noteRepository.getDistinctTags(user);
    }
}
