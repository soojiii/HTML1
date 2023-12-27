package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public interface  IMemberService  {

	
	public String selectById(String name);

	public List<ZipVO> selectByDong(String a);

	public int insertMember(MemberVO vo);

}
