package lexek.notes.controllers.api;

import lexek.notes.dao.UserRepository;
import lexek.notes.models.User;
import lexek.notes.models.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/register")
public class RegisterController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public RegisterController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @RequestMapping(method = RequestMethod.GET)
    public String doGet() {
        return "register";
    }

    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String register(
            @RequestParam(value = "name", required = true) String name,
            @RequestParam(value = "password", required = true) String password,
            @RequestParam(value = "email", required = true) String email,
            Model model) {
        userRepository.save(new User(null, name, email, passwordEncoder.encode(password), UserRole.USER));
        return "redirect:/";
    }

    @RequestMapping(method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public void registerJson(
            @RequestParam(value = "name", required = true) String name,
            @RequestParam(value = "password", required = true) String password,
            @RequestParam(value = "email", required = true) String email,
            Model model) {
        userRepository.save(new User(null, name, email, passwordEncoder.encode(password), UserRole.USER));
        model.asMap().put("success", true);
    }
}
