package lexek.notes.dao;

import lexek.notes.models.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {
    User findByName(String name);
}
