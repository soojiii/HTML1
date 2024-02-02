package kr.or.ddit.board.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageVO;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.config.MybatisUtil;

public class BoardDaoImpl implements IBoardDao{
	private static IBoardDao dao;
	private BoardDaoImpl() { }
	public static IBoardDao getDao() {
		if(dao==null) dao = new BoardDaoImpl();
		return dao;
	}
	
	
	@Override
	public List<BoardVO> selectByPage(Map<String, Object> map) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("board.selectByPage", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		return list;
	}

	@Override
	public int insertBoard(BoardVO vo) {
		int ivo = 0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			ivo = session.insert("board.insertBoard", vo);
			
			if(ivo>0) {
				session.commit();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			if(session!=null) session.close();
		}
		return ivo;
	}

	@Override
	public int updateBoard(BoardVO vo) {
		int uvo = 0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			uvo = session.update("board.updateBoard", vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			if(session!=null) session.close();
		}
		return uvo;
	}

	@Override
	public int deleteBoard(int num) {
		int dvo = 0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			dvo = session.delete("board.deleteBoard", num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			if(session!=null) session.close();
		}
		return dvo;
	}

	@Override
	public int getTotalCount(Map<String, Object> map) {
		int tvo =0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			tvo = session.selectOne("board.getTotalCount", map);
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		return tvo;
	}

	@Override
	public int updateHit(int num) {
		int uvo =0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			uvo = session.update("board.updateHit", num);
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			if(session!=null) session.close();
		}
		return uvo;
	}
	@Override
	public int insertReply(ReplyVO vo) {
		int uvo =0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			uvo = session.insert("reply.insertReply", vo);
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			if(session!=null) session.close();
		}
		return uvo;
	}
	@Override
	public int updateReply(ReplyVO vo) {
		int uvo =0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			uvo = session.update("reply.updateReply", vo);
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			if(session!=null) session.close();
		}
		return uvo;
	}
	@Override
	public int deleteReply(int renum) {
		int uvo =0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			uvo = session.delete("reply.deleteReply", renum);
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			if(session!=null) session.close();
		}
		return uvo;
	}
	@Override
	public List<ReplyVO> replyList(int bonum) {
		List<ReplyVO> list = new ArrayList<ReplyVO>();
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("reply.replyList", bonum);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			if(session!=null) session.close();
		}
		return list;
	}
	
//	@Override
//	public PageVO pageInfo(int pageNo, String stype, String sword) {
//		// TODO Auto-generated method stub
//		return null;
//	}
	
}
