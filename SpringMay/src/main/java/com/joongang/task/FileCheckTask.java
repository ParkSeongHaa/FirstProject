package com.joongang.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.joongang.domain.BoardAttachVO;
import com.joongang.domain.BookAttachVO;
import com.joongang.mapper.BoardAttachMapper;
import com.joongang.mapper.BookAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Component // @Component is a class level annotation
public class FileCheckTask {
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Setter(onMethod_=@Autowired)
	private BookAttachMapper bookattachMapper;
	
	@Scheduled( cron = "0 0 0 ? * SUN" ) //(cron = "0 * * ? * *"); cron = "0 0 0 ? * SUN"
	public void checkFiles() throws Exception {
		log.info("checkFiles");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String uploadpath = sdf.format(cal.getTime());
		String bookuploadpath = sdf.format(cal.getTime());										//book
		for (int i=0; i<DayOfWeek.SUNDAY.getValue(); i++) {
			cal.add(Calendar.DATE,  -1);
			uploadpath = sdf.format(cal.getTime()).replace("-", "\\");
					log.info("cal uploadpath :" + uploadpath );
			bookuploadpath = sdf.format(cal.getTime()).replace("-", "\\");						//book
					log.info("cal bookuploadpath :" + bookuploadpath );
			List<BoardAttachVO> fileList = attachMapper.getOldFiles(uploadpath);
			List<BookAttachVO> bookfileList = bookattachMapper.getOldFiles(uploadpath);				//book
			
			//files on the tbl_attach.
			List<Path> fileListPaths = new ArrayList<Path>();
			List<Path> bookfileListPaths = new ArrayList<Path>();								//book
			for(BoardAttachVO vo : fileList) {
				fileListPaths.add(Paths.get("C:\\upload",vo.getUploadpath(),vo.getUuid() + "_"+vo.getFilename()));
				if(vo.isFiletype()) {
					fileListPaths.add(Paths.get("C:\\upload",vo.getUploadpath(),"s_"+vo.getUuid()+"_"+vo.getFilename()));
				}
			}
			for(BookAttachVO bookvo : bookfileList) {												//book
				bookfileListPaths.add(Paths.get("C:\\upload",bookvo.getUploadpath(),bookvo.getUuid() + "_"+bookvo.getFilename()));
				/*if(bookvo.isFiletype()) {*/
					bookfileListPaths.add(Paths.get("C:\\upload",bookvo.getUploadpath(),"s_"+bookvo.getUuid()+"_"+bookvo.getFilename()));
					/* } */
			}
			log.info("--------------------------------");
			log.info("database files-----");
			for(Path path : fileListPaths) {
				log.info(path.toString());
			}
			for(Path bookpath : bookfileListPaths) {															//book
				log.info(bookpath.toString());
			}
			//files on the directory
			log.info("-------------------------------------");
			File dir = Paths.get("C:\\upload",uploadpath).toFile();
			File bookdir = Paths.get("C:\\upload",bookuploadpath).toFile();									//book
			if(dir == null) continue;
//			for(File file : dir.listFiles()) {				//삭제부분 잠시 주석처리
//				if(!fileListPaths.contains(file.toPath())) {
//					log.info("this file will be delete-----");
//					log.info(file.getAbsolutePath());
//					file.delete();
//				}
//			}
//			for(File file : bookdir.listFiles()) {															//book
//				if(!bookfileListPaths.contains(file.toPath())) {
//					log.info("this file will be delete-----");
//					log.info(file.getAbsolutePath());
//					file.delete();
//				}
//			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
