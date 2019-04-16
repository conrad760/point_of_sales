using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using point_of_sales;

namespace point_of_sales.Controllers
{
    public class EmployeesController : Controller
    {
        private coffee_context db = new coffee_context();

        // GET: Employees
        public ActionResult Index()
        {
            var employees = db.Employees.Include(e => e.Access_level).Include(e => e.Employee1);
            return View(employees.ToList());
        }

        // GET: Employees/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Employee employee = db.Employees.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(employee);
        }

        // GET: Employees/Create
        public ActionResult Create()
        {
            ViewBag.employee_access_code = new SelectList(db.Access_level, "access_code", "access_value");
            ViewBag.hired_by_id = new SelectList(db.Employees, "employee_id", "employee_email");
            return View();
        }

        // POST: Employees/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "employee_id,employee_email,employee_first_name,employee_last_name,employee_access_code,employee_data_of_birth,date_hired,hired_by_id,hours_per_week,sex")] Employee employee)
        {
            if (ModelState.IsValid)
            {
                db.Employees.Add(employee);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.employee_access_code = new SelectList(db.Access_level, "access_code", "access_value", employee.employee_access_code);
            ViewBag.hired_by_id = new SelectList(db.Employees, "employee_id", "employee_email", employee.hired_by_id);
            return View(employee);
        }

        // GET: Employees/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Employee employee = db.Employees.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            ViewBag.employee_access_code = new SelectList(db.Access_level, "access_code", "access_value", employee.employee_access_code);
            ViewBag.hired_by_id = new SelectList(db.Employees, "employee_id", "employee_email", employee.hired_by_id);
            return View(employee);
        }

        // POST: Employees/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "employee_id,employee_email,employee_first_name,employee_last_name,employee_access_code,employee_data_of_birth,date_hired,hired_by_id,hours_per_week,sex")] Employee employee)
        {
            if (ModelState.IsValid)
            {
                db.Entry(employee).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.employee_access_code = new SelectList(db.Access_level, "access_code", "access_value", employee.employee_access_code);
            ViewBag.hired_by_id = new SelectList(db.Employees, "employee_id", "employee_email", employee.hired_by_id);
            return View(employee);
        }

        // GET: Employees/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Employee employee = db.Employees.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(employee);
        }

        // POST: Employees/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Employee employee = db.Employees.Find(id);
            db.Employees.Remove(employee);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
