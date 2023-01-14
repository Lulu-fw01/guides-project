package paper.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import paper.dto.GuideDTO;
import paper.entities.Guide;
import paper.services.GuideHandleService;

import java.util.List;

@RestController
@RequestMapping(path = "api/v1/guide-handling")
public class GuideHandleController {

    private final GuideHandleService guideHandleService;

    @Autowired
    public GuideHandleController(GuideHandleService guideHandleService) {
        this.guideHandleService = guideHandleService;
    }

    @PostMapping
    public void createGuide(@RequestBody Guide guide) {
        guideHandleService.createGuide(guide);
    }

    @DeleteMapping
    public void removeGuide(@RequestBody Long id) {
        guideHandleService.removeGuide(id);
    }

    @GetMapping
    public List<GuideDTO> getListOfAllGuides() {
        return guideHandleService.getListOfAllGuides();
    }

    @PutMapping
    public void editGuide(@RequestBody Guide guide) {
        guideHandleService.editGuide(guide);
    }

    // TODO: PATCH method to edit instead of PUT
}
