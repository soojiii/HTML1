package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public class MemberServiceImpl implements IMemberService{
	//dao객체가 필요 - dao메소드 호출 - 결과값을 받아서 controller로 넘김
	private IMemberDao dao;
	
	//싱글톤 자신의 객체
	private static IMemberService service;
	
	//생성자 - dao객체 얻어오기
	private MemberServiceImpl() {
		dao = MemberDaoImpl.getDao();
	}
	
	//싱글톤 자신의 객체 생성하고 리턴
	public static IMemberService getService() {
		if(service == null) service = new MemberServiceImpl();
		return service;
	}
	

	@Override
	public String selectById(String id) {
		return dao.selectById(id);
	}

	@Override
	public List<ZipVO> selectByDong(String dong) {
		return dao.selectByDong(dong);
	}

	@Override
	public int insertMember(MemberVO vo) {
		return dao.insertMember(vo);
	}

	@Override
	public MemberVO logSelect(MemberVO vo) {
		return dao.logSelect(vo);
	}
	
}
