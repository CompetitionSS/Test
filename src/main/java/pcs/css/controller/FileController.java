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
   public ResponseEntity<FileResponse> upload (@RequestParam MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws Exception {

        return new ResponseEntity<>(FileResponse.builder().
                uploaded(true).
                url(fileService.upload(upload)).
                build(), HttpStatus.OK);

    }

    @RequestMapping(value="notice/NoticeReg")
    public void ckSubmit(
             @RequestParam(value="fileName") String fileName,@RequestParam(value="uid") String uid ,HttpServletResponse response)
            throws ServletException, IOException{
        log.info("들어와지나?");
        //서버에 저장된 이미지 경로

        String path = "D:\\test\\src\\main\\webapp\\WEB-INF\\image" + "upload/";	// 저장된 이미지 경로
        System.out.println("path:"+path);
        String sDirPath = path + uid + "_" + fileName;
        File imgFile = new File(sDirPath);

        //사진 이미지 찾지 못하는 경우 예외처리로 빈 이미지 파일을 설정한다.
        if(imgFile.isFile()){
            byte[] buf = new byte[1024];
            int readByte = 0;
            int length = 0;
            byte[] imgBuf = null;

            FileInputStream fileInputStream = null;
            ByteArrayOutputStream outputStream = null;
            ServletOutputStream out = null;

            try{
                fileInputStream = new FileInputStream(imgFile);
                outputStream = new ByteArrayOutputStream();
                out = response.getOutputStream();

                while((readByte = fileInputStream.read(buf)) != -1){
                    outputStream.write(buf, 0, readByte);
                }

                imgBuf = outputStream.toByteArray();
                length = imgBuf.length;
                out.write(imgBuf, 0, length);
                out.flush();

            }catch(IOException e){
                e.printStackTrace();
            }finally {
                outputStream.close();
                fileInputStream.close();
                out.close();
            }
        }
    }
}
