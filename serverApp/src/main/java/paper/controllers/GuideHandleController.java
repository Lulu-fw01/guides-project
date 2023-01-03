package paper.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import paper.models.Guide;
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
        System.out.println(guide.getTitle());
        guideHandleService.createGuide(guide);
    }

    @DeleteMapping
    public void removeGuide(@RequestBody Guide guide) {
        guideHandleService.removeGuide(guide);
    }

    @GetMapping
    public List<Guide> getListOfAllGuides() {
        return guideHandleService.getListOfAllGuides();
    }

    @PutMapping
    public void editGuide(@RequestBody Guide guide) {
        guideHandleService.editGuide(guide);
    }

    // TODO: PATCH method to edit instead of PUT
}
