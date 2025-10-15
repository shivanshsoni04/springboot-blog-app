package com.blog.BloggingProject.repository;

import com.blog.BloggingProject.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostRepo extends JpaRepository<Post,Integer> {
}
