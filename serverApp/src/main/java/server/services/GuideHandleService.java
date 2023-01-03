package server.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import server.models.Guide;
import server.repository.GuideHandleRepository;

import java.util.List;

@Service
public class GuideHandleService {

    private final GuideHandleRepository guideHandleRepository;

    @Autowired
    public GuideHandleService(GuideHandleRepository guideHandleRepository) {
        this.guideHandleRepository = guideHandleRepository;
    }

    public void createGuide(Guide guide) {
        if (guide == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        guideHandleRepository.save(guide);
    }

    public void removeGuide(Guide guide) {
        if (guide == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        guideHandleRepository.deleteById(guide.getId());
    }

    public List<Guide> getListOfAllGuides() {
        return guideHandleRepository.findAll();
    }

    public void editGuide(Guide guide) {
        if (guide == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var selectedGuide = guideHandleRepository.findById(guide.getId());

        selectedGuide.ifPresent(value -> {
            value.setId(guide.getId());
            value.setCreatorEmail(guide.getCreatorEmail());
            value.setEditDate(guide.getEditDate());
            value.setTitle(guide.getTitle());
            value.setFileBytes(guide.getFileBytes());
            value.setIsBlocked(guide.getIsBlocked());
        });

        selectedGuide.ifPresent(guideHandleRepository::save);

        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Could not find the object by given id");
    }
}
