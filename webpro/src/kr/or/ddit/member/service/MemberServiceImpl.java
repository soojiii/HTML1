package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public class MemberServiceImpl  implements IMemberService  {
	
	private static MemberServiceImpl instance = null;

	private MemberServiceImpl() {
	}

	public static MemberServiceImpl getInstance() {
		if (instance == null) {
			instance = new MemberServiceImpl();

		}
		return instance;
	}
	
	MemberDaoImpl dao = MemberDaoImpl.getInstance();
	
	@Override
	public String selectById(String name) {
		
		return dao.selectById(name);
		
	}

	@Override
	public List<ZipVO> selectByDong(String a) {
		
		return dao.selectByDong(a);
	}

	@Override
	public int insertMember(MemberVO vo) {
		
		return dao.insertMember(vo);
	}

}
