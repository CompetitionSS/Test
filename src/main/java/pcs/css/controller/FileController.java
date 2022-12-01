package pcs.css.controller;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import pcs.css.dto.FileDTO;
import pcs.css.dto.FileResponse;
import pcs.css.service.impl.FileService;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Objects;
import java.util.UUID;




@CrossOrigin(origins = "*")
@RequiredArgsConstructor
@Slf4j
@Controller
public class FileController {

    @Resource(name = "FileService")
    private FileService fileService;
    @Value("${cloud.aws.s3.bucket}")
    private String S3Bucket; // Bucket 이름
    @PostMapping("/notice/upload")
   public ResponseEntity<FileResponse> upload (@RequestParam MultipartFile upload) throws Exception {

        return new ResponseEntity<>(FileResponse.builder().
                uploaded(true).
                url(fileService.upload(upload)).
                build(), HttpStatus.OK);

    }
}
