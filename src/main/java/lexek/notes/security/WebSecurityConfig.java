package lexek.notes.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.csrf.CsrfTokenRepository;
import org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository;

import javax.sql.DataSource;

@Configuration
@EnableWebMvcSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    private PersistentTokenRepository persistentTokenRepository;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/public/**", "/css/**", "/js/**", "/fonts/**", "/vendor/**", "/register").permitAll()
                .antMatchers("/**").authenticated().and()
                .formLogin()
                .loginPage("/login.html")
                .loginProcessingUrl("/login")
                .passwordParameter("password")
                .usernameParameter("name")
                .permitAll()
                .and()
                .rememberMe()
                .tokenRepository(persistentTokenRepository)
                .tokenValiditySeconds(1209600).and()
                .logout()
                .logoutUrl("/logout")
                .deleteCookies("remember-me")
                .permitAll().and()
                .csrf()
                .csrfTokenRepository(csrfTokenRepository()).and()
                .addFilterAfter(new CsrfHeaderFilter(), CsrfFilter.class);
    }

    @Autowired
    public void setPersistentTokenRepository(PersistentTokenRepository persistentTokenRepository) {
        this.persistentTokenRepository = persistentTokenRepository;
    }

    @Bean
    @Autowired
    public PersistentTokenRepository persistentTokenRepository(DataSource dataSource) {
        JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
        db.setDataSource(dataSource);
        return db;
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth, UserDetailsService userDetailsService) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    private CsrfTokenRepository csrfTokenRepository() {
        HttpSessionCsrfTokenRepository repository = new HttpSessionCsrfTokenRepository();
        repository.setHeaderName("X-XSRF-TOKEN");
        return repository;
    }
}
