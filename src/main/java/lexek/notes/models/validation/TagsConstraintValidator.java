package lexek.notes.models.validation;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.List;

public class TagsConstraintValidator implements ConstraintValidator<Tags, List<String>> {
    @Override
    public void initialize(Tags constraintAnnotation) {
    }

    @Override
    public boolean isValid(List<String> value, ConstraintValidatorContext context) {
        if (value.isEmpty() || value.size() >= 8) {
            return false;
        }
        for (String tag : value) {
            if (tag.length() < 2 || tag.length() > 5) {
                return false;
            }
        }
        return true;
    }
}
