<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<form name="f">
아이디는 ${id}
차단 아이디는 ${blockId}
<input type="text" placeholder="메모내용을 입력해주세요">
<input type="submit">
<input type="button" value="취소" onclick="javascript:cancel">
</form>