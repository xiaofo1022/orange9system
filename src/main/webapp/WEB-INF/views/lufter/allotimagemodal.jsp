<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<div id="allotImageModal" class="modal fade text-left" tabindex="-1" role="dialog" aria-hidden="true">
	<input id="allot-order-id" type="hidden"/>
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">分图 <span id="unallot-count"></span> 张未分</h4>
			</div>
			<div class="modal-body">
				<c:forEach items="${designerList}" var="designer">
					<div class="clearfix">
						<div class="data-info facebook-bc order-detail-header" style="margin-left:0px;">
							${designer.name} <img src="${designer.header}"/>
							<input id="designer-${designer.id}" class="designer-list" type="hidden" value="${designer.id}"/>
						</div>
						<div class="col-sm-4">
							<input id="allot-count-${designer.id}" type="number" value="0" min="0" max="9999" step="1" class="form-control allot-pick-number"/>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="modal-footer">
				<button id="btnAllotImage" type="button" class="btn btn-primary" onclick="allotImage()">确定</button>
			</div>
		</div>
	</div>
</div>

<script>
	var allotUri = "";

	function showAllotImageModal(orderId, count) {
		$("#allot-order-id").val(orderId);
		$("#unallot-count").text(count);
		$("#allotImageModal").modal("show");
	}
	
	function allotImage() {
		var orderId = $("#allot-order-id").val();
		var allotList = [];
		var allotMaxCount = parseInt($("#unallot-count").text());
		var count = 0;
		$(".designer-list").each(function(index, data) {
			var id = data.id;
			var designerId = id.replace("designer-", "");
			var allotCountInput = $("#allot-count-" + designerId);
			var allotCount = allotCountInput.val();
			count += parseInt(allotCount);
			allotList.push({designerId:designerId, allotCount:allotCount});
		});
		if (count > allotMaxCount) {
			alert("分图数量不能大于总数");
			return;
		}
		AjaxUtil.post("<c:url value='/orderPostProduction/" + allotUri + "/" + orderId + "'/>", allotList, function(data) {
			location.reload(true);
		});
	}
</script>