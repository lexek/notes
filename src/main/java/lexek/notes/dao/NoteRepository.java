package lexek.notes.dao;

import lexek.notes.models.Note;
import lexek.notes.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface NoteRepository extends PagingAndSortingRepository<Note, Long> {
    Page<Note> findByOwner(User owner, Pageable pageable);

    Page<Note> findByOwnerAndTags(User owner, String tag, Pageable pageable);

    @Query(value = "select tag, count(tag) from Note n join n.tags tag where n.owner = :owner group by tag order by count(tag) desc")
    List getDistinctTags(@Param("owner") User owner);
}
