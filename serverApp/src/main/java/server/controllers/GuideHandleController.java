package server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import server.models.Guide;
import server.services.GuideHandleService;

import java.util.List;

@Controller("api/v1/guide-handling")
public class GuideHandleController {

    private final GuideHandleService guideHandleService;

    @Autowired
    public GuideHandleController(GuideHandleService guideHandleService) {
        this.guideHandleService = guideHandleService;
    }

    @PostMapping
    public void createGuide(Guide guide) {
        guideHandleService.createGuide(guide);
    }

    @DeleteMapping
    public void removeGuide(Guide guide) {
        guideHandleService.removeGuide(guide);
    }

    @GetMapping
    public List<Guide> getListOfAllGuides() {
        return guideHandleService.getListOfAllGuides();
    }

    @PutMapping
    public void editGuide(Guide guide) {
        guideHandleService.editGuide(guide);
    }

    // TODO: PATCH method to edit instead of PUT
}
