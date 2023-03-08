package com.server.controllers;

import com.server.dto.GuideDTO;
import com.server.services.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/v1/search")
public class SearchController {

    private final SearchService searchService;

    @Autowired
    public SearchController(SearchService searchService) {
        this.searchService = searchService;
    }

    @GetMapping("title/{title}/{pageNumber}/{pageSize}")
    public List<GuideDTO> getGuidesByTitle(@PathVariable("title") String title,
                                           @PathVariable("pageNumber") String pageNumber,
                                           @PathVariable("pageSize") String pageSize) {
        return searchService.getGuidesByTitle(title, pageNumber, pageSize);
    }

    @GetMapping("category/{category}/{pageNumber}/{pageSize}")
    public List<GuideDTO> getGuidesByCategory(@PathVariable("category") String category,
                                              @PathVariable("pageNumber") String pageNumber,
                                              @PathVariable("pageSize") String pageSize) {
        return searchService.getGuidesByCategory(category, pageNumber, pageSize);
    }

    @GetMapping("username/{username}/{pageNumber}/{pageSize}")
    public List<GuideDTO> getGuidesByAuthor(@PathVariable("username") String username,
                                            @PathVariable("pageNumber") String pageNumber,
                                            @PathVariable("pageSize") String pageSize) {
        return searchService.getGuidesByAuthor(username, pageNumber, pageSize);
    }
}
