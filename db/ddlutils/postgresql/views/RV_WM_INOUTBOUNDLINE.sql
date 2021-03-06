DROP VIEW RV_WM_InOutBoundLine;
CREATE OR REPLACE  VIEW RV_WM_InOutBoundLine AS
SELECT
  iob.ad_client_id ,
  iob.ad_org_id ,
  iob.created ,
  iob.createdby ,
  iob.isactive ,
  iob.updated ,
  iob.updatedby ,
  iob.c_doctype_id ,
  iob.dateprinted ,
  iob.deliveryrule ,
  iob.deliveryviarule ,
  iob.docaction ,
  iob.docstatus ,
  iob.documentno ,
  iob.dropship_bpartner_id ,
  iob.dropship_location_id ,
  iob.dropship_user_id ,
  iob.freightamt ,
  iob.freightcostrule ,
  iob.m_freightcategory_ID,
  iob.isapproved ,
  iob.isdropship ,
  iob.isintransit ,
  iob.isprinted ,
  iob.issotrx ,
  iob.m_shipper_id ,
  iob.m_warehouse_id ,
  iob.poreference ,
  iob.priorityrule ,
  iob.salesrep_id ,
  iob.trackingno ,
  iob.volume ,
  iob.weight,
  iobl.wm_inoutboundline_id ,
  iobl.ad_orgtrx_id ,
  iobl.c_activity_id ,
  iobl.c_campaign_id ,
  iobl.c_charge_id ,
  iobl.c_orderline_id ,
  iobl.c_projectphase_id ,
  iobl.c_projecttask_id ,
  iobl.c_project_id ,
  iobl.c_uom_id ,
  iobl.description ,
  iobl.isdescription ,
  iobl.line ,
  iobl.m_attributesetinstance_id ,
  iobl.wm_inoutbound_id ,
  iobl.m_product_id ,
  iobl.movementqty ,
  iobl.pickedqty ,
  iobl.processed ,
  iobl.user1_id ,
  iobl.user2_id ,
  iobl.pickdate ,
  iobl.shipdate,
  iobl.pp_mrp_id ,
  iobl.dd_orderline_id ,
  iobl.pp_order_bomline_id ,
  iobl.dd_order_id ,
  iobl.pp_order_id ,
  iobl.c_order_id ,
  ol.QtyOrdered,
  ol.QtyDelivered,
  o.DocumentNo AS ReferenceNo,  o.DateOrdered , o.DatePromised , o.C_BPartner_ID ,
  bomqtyonhand (iobl.m_product_id, iob.m_warehouse_id , 0)  AS qtyonhand,
  bomqtyreserved (iobl.m_product_id, iob.m_warehouse_id , 0 ) AS qtyreserved,
  bomqtyavailable(iobl.m_product_id, iob.m_warehouse_id,0) AS qtyavailable
FROM WM_InOutBoundLine iobl
INNER JOIN WM_InOutBound iob ON (iob.WM_InOutBound_ID=iobl.WM_InOutBound_ID)
INNER JOIN C_OrderLine ol ON (ol.C_OrderLine_ID= iobl.C_OrderLine_ID)
INNER JOIN C_Order o ON (o.C_Order_ID = ol.C_Order_ID)
INNER JOIN C_BPartner bp ON (bp.C_BPartner_ID=ol.C_BPartner_ID)
WHERE NOT EXISTS (SELECT 1 FROM M_InOutLine WHERE M_InOutLine.C_OrderLine_ID = iobl.C_OrderLine_ID AND iobl.PickedQty >= M_InOutLine.MovementQty)  AND iob.IsSOTrx='Y' AND iobl.Processed='Y' AND ol.QtyOrdered <> ol.QtyDelivered
UNION
SELECT
  iob.ad_client_id ,
  iob.ad_org_id ,
  iob.created ,
  iob.createdby ,
  iob.isactive ,
  iob.updated ,
  iob.updatedby ,
  iob.c_doctype_id ,
  iob.dateprinted ,
  iob.deliveryrule ,
  iob.deliveryviarule ,
  iob.docaction ,
  iob.docstatus ,
  iob.documentno ,
  iob.dropship_bpartner_id ,
  iob.dropship_location_id ,
  iob.dropship_user_id ,
  iob.freightamt ,
  iob.freightcostrule ,
  iob.m_freightcategory_ID,
  iob.isapproved ,
  iob.isdropship ,
  iob.isintransit ,
  iob.isprinted ,
  iob.issotrx ,
  iob.m_shipper_id ,
  iob.m_warehouse_id ,
  iob.poreference ,
  iob.priorityrule ,
  iob.salesrep_id ,
  iob.trackingno ,
  iob.volume ,
  iob.weight,
  iobl.wm_inoutboundline_id ,
  iobl.ad_orgtrx_id ,
  iobl.c_activity_id ,
  iobl.c_campaign_id ,
  iobl.c_charge_id ,
  iobl.c_orderline_id ,
  iobl.c_projectphase_id ,
  iobl.c_projecttask_id ,
  iobl.c_project_id ,
  iobl.c_uom_id ,
  iobl.description ,
  iobl.isdescription ,
  iobl.line ,
  iobl.m_attributesetinstance_id ,
  iobl.wm_inoutbound_id ,
  iobl.m_product_id ,
  iobl.movementqty ,
  iobl.pickedqty ,
  iobl.processed ,
  iobl.user1_id ,
  iobl.user2_id ,
  iobl.pickdate ,
  iobl.shipdate,
  iobl.pp_mrp_id ,
  iobl.dd_orderline_id ,
  iobl.pp_order_bomline_id ,
  iobl.dd_order_id ,
  iobl.pp_order_id ,
  iobl.c_order_id ,
  ol.QtyOrdered,
  ol.QtyDelivered ,
o.DocumentNo AS ReferenceNo , o.DateOrdered , o.DatePromised , o.C_BPartner_ID ,
bomqtyonhand (iobl.m_product_id, iob.m_warehouse_id,0)  AS qtyonhand,
bomqtyreserved (iobl.m_product_id, iob.m_warehouse_id,0 ) AS qtyreserved,
bomqtyavailable(iobl.m_product_id, iob.m_warehouse_id,0) AS qtyavailable
FROM WM_InOutBoundLine iobl
INNER JOIN WM_InOutBound iob ON (iob.WM_InOutBound_ID=iobl.WM_InOutBound_ID)
INNER JOIN DD_OrderLine ol ON (ol.DD_OrderLine_ID= iobl.DD_OrderLine_ID)
INNER JOIN DD_Order o ON (o.DD_Order_ID = ol.DD_Order_ID)
INNER JOIN C_BPartner bp ON (bp.C_BPartner_ID=o.C_BPartner_ID)
WHERE NOT EXISTS (SELECT 1 FROM M_MovementLine WHERE M_MovementLine.DD_OrderLine_ID = iobl.DD_OrderLine_ID AND iobl.PickedQty >= M_MovementLine.MovementQty)  AND iob.IsSOTrx='Y' AND iobl.Processed='Y' AND ol.QtyOrdered <> ol.QtyDelivered
UNION
SELECT
    iob.ad_client_id ,
  iob.ad_org_id ,
  iob.created ,
  iob.createdby ,
  iob.isactive ,
  iob.updated ,
  iob.updatedby ,
  iob.c_doctype_id ,
  iob.dateprinted ,
  iob.deliveryrule ,
  iob.deliveryviarule ,
  iob.docaction ,
  iob.docstatus ,
  iob.documentno ,
  iob.dropship_bpartner_id ,
  iob.dropship_location_id ,
  iob.dropship_user_id ,
  iob.freightamt ,
  iob.freightcostrule ,
  iob.m_freightcategory_ID,
  iob.isapproved ,
  iob.isdropship ,
  iob.isintransit ,
  iob.isprinted ,
  iob.issotrx ,
  iob.m_shipper_id ,
  iob.m_warehouse_id ,
  iob.poreference ,
  iob.priorityrule ,
  iob.salesrep_id ,
  iob.trackingno ,
  iob.volume ,
  iob.weight,
  iobl.wm_inoutboundline_id ,
  iobl.ad_orgtrx_id ,
  iobl.c_activity_id ,
  iobl.c_campaign_id ,
  iobl.c_charge_id ,
  iobl.c_orderline_id ,
  iobl.c_projectphase_id ,
  iobl.c_projecttask_id ,
  iobl.c_project_id ,
  iobl.c_uom_id ,
  iobl.description ,
  iobl.isdescription ,
  iobl.line ,
  iobl.m_attributesetinstance_id ,
  iobl.wm_inoutbound_id ,
  iobl.m_product_id ,
  iobl.movementqty ,
  iobl.pickedqty ,
  iobl.processed ,
  iobl.user1_id ,
  iobl.user2_id ,
  iobl.pickdate ,
  iobl.shipdate,
  iobl.pp_mrp_id ,
  iobl.dd_orderline_id ,
  iobl.pp_order_bomline_id ,
  iobl.dd_order_id ,
  iobl.pp_order_id ,
  iobl.c_order_id,
  ol.QtyRequired,
  ol.QtyDelivered ,
  o.DocumentNo AS ReferenceNo , o.DateOrdered , o.DatePromised , bp.C_BPartner_ID,
  bomqtyonhand (iobl.m_product_id, iob.m_warehouse_id , 0)  AS qtyonhand,
  bomqtyreserved (iobl.m_product_id, iob.m_warehouse_id , 0 ) AS qtyreserved ,
  bomqtyavailable(iobl.m_product_id, iob.m_warehouse_id,0) AS qtyavailable
FROM WM_InOutBoundLine iobl
INNER JOIN WM_InOutBound iob ON (iob.WM_InOutBound_ID=iobl.WM_InOutBound_ID)
INNER JOIN pp_order_bomline ol ON (ol.pp_order_bomline_id= iobl.pp_order_bomline_id)
INNER JOIN PP_Order o ON (o.PP_Order_ID = ol.PP_Order_ID)
LEFT JOIN C_BPartner bp ON (o.AD_Org_ID = AD_OrgBP_ID)
WHERE NOT EXISTS (SELECT 1 FROM PP_Cost_Collector cc WHERE cc.pp_order_bomline_ID = iobl.pp_order_bomline_id AND iobl.PickedQty >= cc.MovementQty)  AND iob.IsSOTrx='Y' AND iobl.Processed='Y' AND ol.QtyRequired <> ol.QtyDelivered;