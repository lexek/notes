package lexek.notes.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import lexek.notes.views.json.FullNote;
import lexek.notes.views.json.NoteSummary;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "note")
public class Note {
    @JsonView(NoteSummary.class)
    @Id
    @Basic
    @GeneratedValue()
    @Column(name = "id")
    private Long id;

    @JsonView(NoteSummary.class)
    @Basic
    @Column(name = "title", nullable = false, length = 128)
    private String title;

    @JsonView(NoteSummary.class)
    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false)
    private NoteType type;

    @JsonView(NoteSummary.class)
    @Basic
    @Column(name = "last_modified", nullable = false)
    private Date lastModified;

    @JsonView(FullNote.class)
    @Basic
    @Lob
    @Column(name = "text", nullable = false)
    private String text;

    @JsonView(FullNote.class)
    @ElementCollection
    @CollectionTable(
            name = "tag",
            joinColumns = {@JoinColumn(name = "note_id")},
            uniqueConstraints = {@UniqueConstraint(columnNames = {"tag", "note_id"})})
    @Column(name = "tag", nullable = false)
    private List<String> tags;

    @JsonIgnore
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id", nullable = false)
    private User owner;

    public Note() {
    }

    public Note(String title, NoteType type, Date lastModified, List<String> tags, String text, User owner) {
        this.title = title;
        this.type = type;
        this.lastModified = lastModified;
        this.tags = tags;
        this.text = text;
        this.owner = owner;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<String> getTags() {
        return tags;
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public Date getLastModified() {
        return lastModified;
    }

    public void setLastModified(Date lastModified) {
        this.lastModified = lastModified;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public NoteType getType() {
        return type;
    }

    public void setType(NoteType type) {
        this.type = type;
    }
}
