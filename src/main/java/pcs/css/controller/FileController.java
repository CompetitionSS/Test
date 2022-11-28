package pcs.css.controller;


import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import pcs.css.service.impl.FileService;

import javax.annotation.Resource;


@Controller
public class FileController {

    @Resource(name = "FileService")
    private FileService fileService;

    @PostMapping("/upload")
   public ResponseEntity<Object> upload(MultipartFile[] multipartFileList) throws Exception {
        return fileService.upload(multipartFileList);
    }
}
