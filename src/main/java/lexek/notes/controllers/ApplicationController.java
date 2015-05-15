package lexek.notes.controllers;

import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class ApplicationController {
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main(@AuthenticationPrincipal Object principal, Model model) {
        model.addAttribute("principal", principal);
        return "main";
    }

    @RequestMapping(value = "/login.html", method = RequestMethod.GET)
    public String loginForm(Model model, @RequestParam Optional<String> error) {
        model.asMap().put("error", error);
        return "login";
    }
}
