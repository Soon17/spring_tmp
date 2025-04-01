package kr.kh.tmp.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.tmp.dao.PostDAO;
import kr.kh.tmp.model.vo.BoardVO;
import kr.kh.tmp.model.vo.FileVO;
import kr.kh.tmp.model.vo.MemberVO;
import kr.kh.tmp.model.vo.PostVO;
import kr.kh.tmp.pagination.Criteria;
import kr.kh.tmp.pagination.PageMaker;
import kr.kh.tmp.pagination.PostCriteria;
import kr.kh.tmp.utils.UploadFileUtils;

@Service
public class PostServiceImp implements PostService {

	@Autowired
	private PostDAO postDao;
	
	@Resource
	String uploadPath;

	@Override
	public boolean insertBoard(String name) {
		try {
			return postDao.insertBoard(name);
		}catch (Exception e) {
			return false;
		}
	}

	@Override
	public List<BoardVO> getBoardList() {
		return postDao.selectBoardList();
	}

	@Override
	public boolean updateBoard(BoardVO board) {
		if(board == null) {
			return false;
		}
		
		try {
			return postDao.updateBoard(board);
		}catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean deleteBoard(int num) {
		return postDao.deleteBoard(num);
	}

	@Override
	public List<PostVO> getPostList(Criteria cri) {
		return postDao.selectPostList(cri);
	}

	@Override
	public boolean insertPost(PostVO post, MemberVO user, MultipartFile[] fileList) {

		if(user == null || post == null) return false;
		
		post.setPo_me_id(user.getMe_id());
		
		boolean res = postDao.insertPost(post);
		
		if(!res) {
			return false;
		}
		
		//첨부파일이 없는 경우
		
		if(fileList == null || fileList.length == 0) {
			return true;
		}
		
		//첨부 파일 등록
		for(MultipartFile file : fileList) {
			uploadFile(file, post.getPo_num());
		}
		
		return true;
	}
	
	private void uploadFile(MultipartFile file, int po_num) {
		if(file == null || file.getOriginalFilename().length() == 0) {
			return;
		}
		
		//서버에 업로드
		String fi_ori_name = file.getOriginalFilename();
		String fi_name;
		try {
			fi_name = UploadFileUtils.uploadFile(uploadPath, fi_ori_name, file.getBytes());
			//DB에 추가
			FileVO fileVo = new FileVO(po_num, fi_name, fi_ori_name);
			postDao.insertFile(fileVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateView(int po_num) {
		postDao.updateView(po_num);
	}

	@Override
	public PostVO getPost(int po_num) {
		
		return postDao.selectPost(po_num);
	}

	@Override
	public boolean deletePost(int po_num, MemberVO user) {
		if(user == null) return false;
		//작성자 체크
		if(!checkWriter(po_num, user)) return false;
		
		//첨부파일 제거
		boolean res =  postDao.deletePost(po_num);

		if(!res) {
			return false;
		}

		//첨부파일 제거
		List<FileVO> list = postDao.selectFileList(po_num);
		//삭제할 첨부파일이 없으면
		if(list == null || list.size() == 0) {
			return true;
		}
		
		for(FileVO file : list) {
			deleteFile(file);
		}
		
		
		return true;
	}
	
	private void deleteFile(FileVO file) {
		if(file == null) {
			return;
		}
		//서버에서 삭제
		UploadFileUtils.deleteFile(uploadPath, file.getFi_name());
		//db에서 삭제
		postDao.deleteFile(file.getFi_num());
	}
	
	private boolean checkWriter(int po_num, MemberVO user) {
		if(user ==null) return false;
		PostVO post = postDao.selectPost(po_num);
		if(post == null) return false;
		return post.getPo_me_id().equals(user.getMe_id());
	}

	@Override
	public boolean updatePost(PostVO post, MemberVO user
			, MultipartFile[] fileList, int[] delNums) {
		if(user == null || post == null) return false;
		//작성자 체크
		if(!checkWriter(post.getPo_num(), user)) return false;
		
		boolean res = postDao.updatePost(post);
		
		//첨부파일 수정
		if(!res) {
			return false;
		}
		//추후 첨부파일 수정
		//새 첨부파일 추가
		if(fileList != null ) {
			for(MultipartFile file : fileList) {
				uploadFile(file, post.getPo_num());
			}
		}
		//삭제할 첨부파일 제거
		if(delNums == null || delNums.length == 0) {
			return true;
		}
		for(int fi_num : delNums) {
			FileVO fileVo = postDao.selectFile(fi_num);
			if(post.getPo_num() != fileVo.getFi_po_num()) {
				continue;
			}
			deleteFile(fileVo);
		}
		return true;
	}

	@Override
	public List<FileVO> getFileList(int po_num) {
		return postDao.selectFileList(po_num);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) {
		if(cri == null) {
			return null;
		}
		int count = postDao.selectCountPostList(cri);
		return new PageMaker(3, cri, count);
	}
}