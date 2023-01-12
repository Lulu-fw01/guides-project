package paper.services;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import paper.config.ConfigYaml;

import java.security.Key;
import java.util.Date;
import java.util.Map;
import java.util.function.Function;

@Service
public class JwtService {

    private final ConfigYaml configYaml;

    @Autowired
    public JwtService(ConfigYaml configYaml) {
        this.configYaml = configYaml;
    }

    // private static final String SEC_TOKEN = "2A472D4B614E645267556B58703273357638792F423F4528482B4D6251655368";

    public String generateToken(Map<String, Object> extraClaims, UserDetails userDetails) {
        return Jwts
                .builder()
                .setClaims(extraClaims)
                .setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 72))
                .signWith(getSignInKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    public <T> T getClaim(String token, Function<Claims, T> claimResolver) {
        return claimResolver.apply(getAllClaims(token));
    }

    public boolean isTokenExpired(String token) {
        return getExpiration(token).before(new Date());
    }

    public boolean isTokenValid(String token, UserDetails userDetails) {
        return getClaim(token, Claims::getSubject).equals(userDetails.getUsername())
                && !isTokenExpired(token);
    }

    private Date getExpiration(String token) {
        return getClaim(token, Claims::getExpiration);
    }

    private Claims getAllClaims(String token) {
        return Jwts
                .parserBuilder()
                .setSigningKey(getSignInKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private Key getSignInKey() {
        var keyBytes = Decoders.BASE64.decode(configYaml.getToken());
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
