package lexek.notes.models.form;

import com.fasterxml.jackson.annotation.JsonProperty;
import lexek.notes.models.NoteType;
import lexek.notes.models.validation.Tags;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

public class NoteForm {
    @Size(min = 4, max = 64)
    @NotEmpty
    private final String title;
    @Size(max = 128_000)
    @NotNull
    private final String text;
    @Tags
    private final List<String> tags;
    @NotNull
    private final NoteType type;

    public NoteForm(
            @JsonProperty("title") String title,
            @JsonProperty("text") String text,
            @JsonProperty("tags") List<String> tags,
            @JsonProperty("type") NoteType type) {
        this.title = title;
        this.text = text;
        this.tags = tags;
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public String getText() {
        return text;
    }

    public List<String> getTags() {
        return tags;
    }

    public NoteType getType() {
        return type;
    }
}
