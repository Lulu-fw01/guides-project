package com.server.controllers;

import com.server.dto.GuideInfoPageResponse;
import com.server.services.SearchService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/search")
public class SearchController {

    private final SearchService searchService;

    @Autowired
    public SearchController(SearchService searchService) {
        this.searchService = searchService;
    }

    @GetMapping("title/{title}/{pageNumber}/{pageSize}")
    @Operation(summary = "Search guides by title")
    @SecurityRequirement(name = "Bearer Authentication")
    public GuideInfoPageResponse getGuidesByTitle(@PathVariable("title") String title,
                                                  @PathVariable("pageNumber") String pageNumber,
                                                  @PathVariable("pageSize") String pageSize) {
        return searchService.getGuidesByTitle(title, pageNumber, pageSize);
    }

    @GetMapping("category/{category}/{pageNumber}/{pageSize}")
    @Operation(summary = "Search guides by category")
    @SecurityRequirement(name = "Bearer Authentication")
    public GuideInfoPageResponse getGuidesByCategory(@PathVariable("category") String category,
                                              @PathVariable("pageNumber") String pageNumber,
                                              @PathVariable("pageSize") String pageSize) {
        return searchService.getGuidesByCategory(category, pageNumber, pageSize);
    }

    @GetMapping("username/{username}/{pageNumber}/{pageSize}")
    @Operation(summary = "Search guides by author")
    @SecurityRequirement(name = "Bearer Authentication")
    public GuideInfoPageResponse getGuidesByAuthor(@PathVariable("username") String username,
                                                @PathVariable("pageNumber") String pageNumber,
                                                @PathVariable("pageSize") String pageSize) {
        return searchService.getGuidesByAuthor(username, pageNumber, pageSize);
    }
}
